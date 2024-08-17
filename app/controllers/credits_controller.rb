# app/controllers/credits_controller.rb
class CreditsController < ApplicationController
  before_action :authenticate_user!

  def create
    amount = params[:credit][:amount].to_i

    if amount <= 0
      render json: { error: 'Invalid credit amount' }, status: :unprocessable_entity and return
    end

    begin
      charge = Stripe::Charge.create({
        amount: amount * 100, # Convert to cents for Stripe
        currency: 'usd',
        customer: current_user.stripe_customer_id,
        description: 'Credit purchase'
      })

      ActiveRecord::Base.transaction do
        credit = current_user.credits.create!(amount: amount)
        current_user.add_credits(amount)

        render json: { message: 'Credits purchased successfully!', credit: credit }, status: :created
      end

    rescue Stripe::CardError => e
      render json: { error: e.message }, status: :payment_required
    rescue => e
      render json: { error: "Something went wrong: #{e.message}" }, status: :internal_server_error
    end
  end
end
