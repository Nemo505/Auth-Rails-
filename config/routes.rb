Rails.application.routes.draw do

  # get "up" => "rails/health#show", as: :rails_health_check
  get "employee", to:"employee#index"
  get "register", to:"auth#register"
end
