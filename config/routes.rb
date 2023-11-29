Rails.application.routes.draw do
  # get "register", to:"auth#register"

  root 'viber_webhook#new'
  resource :registration
  # config/routes.rb
  resources :sessions, only: [:new, :create, :destroy]

  post '/viber_webhook/receive', to: 'viber_webhook#receive'
end
