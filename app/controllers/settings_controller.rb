class SettingsController < ApplicationController
  
  def profile
    @user = current_user
  end

  def update_profile
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to profile_settings_path,notice: "Profile updated successfully."
  end


  private
    def user_params
      params.require(:user).permit(:name,:phone,:no_show_threshold,:time_zone)
    end
end
