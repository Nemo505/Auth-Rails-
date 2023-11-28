Rails.application.routes.draw do
  # get "register", to:"auth#register"

  authenticated_routes = lambda do |request|
    request.env['warden'].authenticate? # Assuming you're using Devise
  end

  constraints(authenticated_routes) do
    # Routes that require authentication go here
    get '/dashboard', to: 'dashboard#index'
    # Add other authenticated routes as needed
  end
  
  root 'chat_bot#index'
  resource :registration
  resource :session
  
  post '/viber_webhook/receive', to: 'viber_webhook#receive'
  get '/chatbot', to: 'chat_bot#index'
  post '/send_message', to: 'chatbot#send_message'
end
