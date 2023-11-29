Rails.application.routes.draw do
  # get "register", to:"auth#register"

  root 'chat_bot#index'
  resource :registration
  # config/routes.rb
  resources :sessions, only: [:new, :create, :destroy]

  
  post '/viber_webhook/receive', to: 'viber_webhook#receive'
  get '/chatbot', to: 'chat_bot#index'
  post '/send_message', to: 'chatbot#send_message'
end
