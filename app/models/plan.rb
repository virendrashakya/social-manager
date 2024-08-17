# app/models/plan.rb

class Plan < ApplicationRecord
  has_many :users  # A plan can have multiple users

  validates :name, inclusion: { in: %w[Free Basic Premium Enterprise], message: "%{value} is not a valid plan name" }
end
