class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable, :recoverable, :validatable, :jwt_authenticatable, jwt_revocation_strategy: self
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # has_secure_password
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, if: :password
  validates :balance, numericality: { greater_than_or_equal_to: 0 }
       
  belongs_to :plan, optional: true  # A user can optionally belong to a plan
  has_many :subscriptions
  has_many :credits

  after_create :set_default_plan

  def generate_jwt_token
    JWT.encode({ user_id: self.id, exp: 24.hours.from_now.to_i }, Rails.application.credentials.secret_key_base)
  end

  # Decode JWT token method (used for logout or other actions)
  def self.decode_jwt_token(token)
    begin
      debugger
      JWT.decode(token, Rails.application.credentials.secret_key_base)
    rescue JWT::ExpiredSignature
      nil # or handle the expiration case
    end
  end

  def add_credits(amount)
    update!(balance: balance + amount)
  end
  
  # Determine if the user is subscribed to a specific plan
  def subscribed_to?(plan_name)
    plan == plan_name
  end

  # Example method to check if the user is on a premium plan
  def premium?
    subscribed_to?('premium')
  end

  # Example method to check if the user is on an enterprise plan
  def enterprise?
    subscribed_to?('enterprise')
  end

  private
  def set_default_plan
    if plan.nil?
      free_plan = Plan.find_by(name: 'Free')
      update(plan: free_plan) if free_plan
    end
  end
end
