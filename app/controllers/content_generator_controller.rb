# app/controllers/content_generator_controller.rb
class ContentGeneratorController < ApplicationController
  def generate
    prompt = params[:prompt]
    api_key = ENV['OPENAI_API_KEY']  # Store your API key in environment variables

    service = ContentGeneratorService.new(api_key)
    generated_content = service.generate_content(prompt)

    render json: { content: generated_content }
  end
end
