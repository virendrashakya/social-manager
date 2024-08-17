# app/jobs/post_job.rb
class PostJob < ApplicationJob
  queue_as :default

  def perform(schedule_id)
    schedule = Schedule.find(schedule_id)
    post = schedule.post

    # Example of posting to a social media API
    SocialMediaService.new.post_content(post.content)

    # Update the schedule status
    schedule.update(status: 'posted')

    # Update analytics (simplified example)
    Analytics.create(post: post, engagement: 0, reach: 0)
  end
end
