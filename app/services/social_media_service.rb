# app/services/social_media_service.rb
class SocialMediaService
  include HTTParty

  def post_content(content)
    # Example POST request to a social media API
    self.class.post('https://api.socialmedia.com/posts', body: { content: content })
  end
end
