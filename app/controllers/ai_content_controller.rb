# app/controllers/ai_content_controller.rb
class AIContentController < ApplicationController
  before_action :authenticate_user!

  def generate_content
    prompt = params[:prompt]

    if current_user.balance < 10
      render json: { error: 'Insufficient credits' }, status: :payment_required and return
    end

    # Simulating AI content generation (replace with actual AI API call)
    generated_content = "Generated content based on the prompt: #{prompt}"

    current_user.update!(balance: current_user.balance - 10)

    render json: { content: generated_content }, status: :ok
  end
end
