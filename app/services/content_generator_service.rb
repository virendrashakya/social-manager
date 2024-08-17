# app/services/content_generator_service.rb
require 'httparty'

class ContentGeneratorService
  include HTTParty
  base_uri 'https://api.openai.com/v1/engines/davinci-codex/completions'

  def initialize(api_key)
    @api_key = api_key
  end

  def generate_content(prompt)
    response = self.class.post(
      '', 
      headers: { 'Authorization' => "Bearer #{@api_key}", 'Content-Type' => 'application/json' },
      body: {
        prompt: prompt,
        max_tokens: 150
      }.to_json
    )
    response.parsed_response['choices'].first['text'].strip
  end
end
