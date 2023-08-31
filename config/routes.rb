Rails.application.routes.draw do
  resources :password_resets, only: [:new, :create, :edit, :update]

  resource :signup, only: [:new, :create]
  get "/login", to: "sessions#new", as: "login"
  post "/sessions", to: "sessions#create"
  get "/logout", to: "sessions#destroy", as: "logout"

  get "pages/landing"

  get "up" => "rails/health#show", :as => :rails_health_check

  root "pages#landing"
end
