# app/controllers/api/sessions_controller.rb

module Api
  class SessionsController < Devise::SessionsController
    include RackSessionsFix
    respond_to :json
    skip_before_action :authenticate_user!, only: [:create]

    def create
      user = User.find_by(email: params[:session][:user][:email])
      if user&.valid_password?(params[:session][:user][:password])
        sign_in user
        render json: { token: user.generate_jwt_token }
        # render json: {
        #   status: { 
        #     code: 200, message: 'Logged in successfully.',
        #     data: { user: UserSerializer.new(current_user).serializable_hash[:data][:attributes] }
        #   }
        # }, status: :ok
      else
        render json: { error: 'Invalid email or password' }, status: :unauthorized
      end
    end

    # def logout
    #   # debugger
    #   token = request.headers['Authorization'].split(' ').last
    #   # decoded_token = User.decode_jwt_token(token)
  
    #   if decoded_token
    #     # Add token to denylist/blacklist here if using a denylist
    #     render json: { message: 'Logged out successfully' }
    #   else
    #     render json: { error: 'Invalid token' }, status: :unauthorized
    #   end
    # end

    private

  #   def respond_with(current_user, _opts = {})
  #     render json: {
  #       status: { 
  #         code: 200, message: 'Logged in successfully.',
  #         data: { user: UserSerializer.new(current_user).serializable_hash[:data][:attributes] }
  #       }
  #     }, status: :ok
  #   end
    def respond_to_on_destroy
      if request.headers['Authorization'].present?
        # debugger

        token = request.headers['Authorization'].split(' ').last
        # jwt_payload = JWT.decode(request.headers['Authorization'].split(' ').last, Rails.application.credentials.secret_key_base!).first        
        jwt_payload = User.decode_jwt_token(token).first
        # debugger
        current_user = User.find(jwt_payload['user_id'])
      end
      
      if current_user
        render json: {
          status: 200,
          message: 'Logged out successfully.'
        }, status: :ok
      else
        render json: {
          status: 401,
          message: "Couldn't find an active session."
        }, status: :unauthorized
      end
    end
  end
end
