# app/controllers/schedules_controller.rb
class SchedulesController < ApplicationController
  def create
    @schedule = Schedule.new(schedule_params)
    if @schedule.save
      PostJob.perform_at(@schedule.scheduled_time, @schedule.id)
      render json: @schedule, status: :created
    else
      render json: @schedule.errors, status: :unprocessable_entity
    end
  end

  private

  def schedule_params
    params.require(:schedule).permit(:post_id, :scheduled_time, :status)
  end
end
