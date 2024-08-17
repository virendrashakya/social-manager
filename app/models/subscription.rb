# app/models/subscription.rb
class Subscription < ApplicationRecord
  belongs_to :user

  validates :plan, presence: true
  validates :status, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true

  def active?
    status == 'active' && end_date > Time.current
  end
end
