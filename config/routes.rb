Rails.application.routes.draw do
  # devise_for :users
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  namespace :api do
    devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'api/sessions',
    registrations: 'api/registrations'
  }, defaults: { format: :json }
  end

  resources :subscriptions, only: [:create]
  resources :credits, only: [:create]
  # post 'signup', to: 'users#create'
  # post 'authenticate', to: 'authentication#authenticate'
  post 'generate_content', to: 'ai_content#generate_content'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
