# app/controllers/api/registrations_controller.rb

module Api
  class RegistrationsController < Devise::RegistrationsController
    include RackSessionsFix
    skip_before_action :authenticate_user!, only: [:create]

    before_action :assign_free_plan, only: [:create]
    
    respond_to :json

    def create
      user = User.new(sign_up_params)
      if user.save
        render json: { message: 'Signed up successfully.', user: user }, status: :created
      else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def assign_free_plan
      if params[:user] && params[:user][:plan_id].blank?
        free_plan = Plan.find_by(name: 'Free')
        params[:user][:plan_id] = free_plan.id if free_plan
      end
    end

    def sign_up_params
      # params.require(:registration).permit(user: [:email, :password, :password_confirmation])

      # devise_parameter_sanitizer.permit(:registration, keys: [:password, :password_confirmation, :plan_id])
      params.require(:user).permit(:username, :email, :password, :password_confirmation, :plan_id)

      # params.require(:user).permit(:email, :password, :password_confirmation)
    end
  end
end
