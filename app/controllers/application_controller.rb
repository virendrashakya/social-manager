# app/controllers/application_controller.rb
class ApplicationController < ActionController::API
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[username email password password_confirmation])
    # devise_parameter_sanitizer.permit(:account_update, keys: %i[name avatar])
  end

  private

  def authenticate_user!
    header = request.headers['Authorization']
    header = header.split(' ').last if header

    decoded = JsonWebToken.decode(header)

    if decoded
      @current_user = User.find(decoded[:user_id])
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  def current_user
    @current_user
  end
end
