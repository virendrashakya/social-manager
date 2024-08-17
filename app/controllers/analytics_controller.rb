# app/controllers/analytics_controller.rb
class AnalyticsController < ApplicationController
  def index
    @analytics = Analytics.all
    render json: @analytics
  end
end
