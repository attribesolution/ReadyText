class Users::RegistrationsController < Devise::RegistrationsController
  before_action :set_restaurant,only: :create
  before_action :configure_permitted_parameters, if: :devise_controller?
  layout 'empty'

  def new
    super
  end

  def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  

  private
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:email,:phone,:password,:password_confirmation,:role,:country_id,:restaurant_id])
    end
  
    def set_restaurant
      if params[:restaurant_name].present?
        restaurant = Restaurant.new(name: params[:restaurant_name],country_id: params[:user][:country_id])
        # set restaurant id in params 
        params[:user][:restaurant_id] = restaurant.id if restaurant.save
      end
    end

end
