# app/controllers/posts_controller.rb
class PostsController < ApplicationController

  before_action :check_premium_access, only: [:create]

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      render json: @post, status: :created
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  private

  def check_premium_access
    unless current_user.subscribed_to_premium?
      render json: { error: 'Premium feature. Upgrade your plan.' }, status: :forbidden
    end
  end

  def post_params
    params.require(:post).permit(:content, :status)
  end
end
