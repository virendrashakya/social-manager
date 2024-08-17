# app/services/stripe_service.rb
class StripeService
  def initialize(api_key)
    @api_key = api_key
  end

  def create_checkout_session(subscription)
    Stripe::Checkout::Session.create({
      payment_method_types: ['card'],
      line_items: [{
        price_data: {
          currency: 'usd',
          product_data: {
            name: subscription.plan
          },
          unit_amount: 5000,  # Amount in cents
        },
        quantity: 1,
      }],
      mode: 'subscription',
      success_url: 'http://localhost:3000/success',
      cancel_url: 'http://localhost:3000/cancel',
    })
  end
end
