# app/controllers/subscriptions_controller.rb
class SubscriptionsController < ApplicationController
  def create
    subscription = current_user.subscriptions.new(subscription_params)
    if subscription.save
      current_user.update(plan: subscription.plan)
      session = Stripe::Checkout::Session.create({
        payment_method_types: ['card'],
        line_items: [{
          price_data: {
            currency: 'usd',
            product_data: {
              name: subscription.plan
            },
            unit_amount: 5000, # Example amount in cents
          },
          quantity: 1,
        }],
        mode: 'subscription',
        success_url: 'http://localhost:3000/success',
        cancel_url: 'http://localhost:3000/cancel',
      })
      render json: { id: session.id }, status: :created
    else
      render json: subscription.errors, status: :unprocessable_entity
    end
  end

  private

  def subscription_params
    params.require(:subscription).permit(:plan, :status, :start_date, :end_date)
  end
end
