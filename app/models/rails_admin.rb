# config/initializers/rails_admin.rb
RailsAdmin.config do |config|
  config.model 'User' do
    edit do
      field :email
      field :plan
    end
  end

  config.model 'Subscription' do
    edit do
      field :user
      field :plan
      field :status
      field :start_date
      field :end_date
    end
  end

  config.model 'Credit' do
    edit do
      field :user
      field :amount
    end
  end
end
