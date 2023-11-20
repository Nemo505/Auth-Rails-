Rails.application.routes.draw do
  # get "register", to:"auth#register"
  resource :registration
  resource :session
  
  root "employee#index"
end
