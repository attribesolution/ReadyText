class ApplicationController < ActionController::Base
  include ActionView::Helpers::UrlHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout :set_layout

  private

  def set_layout
    user_signed_in? ? "application" : (current_page?(root_path) ? "application" : "empty")
  end
end
