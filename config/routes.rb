require "sidekiq/web"

Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq"

  namespace :api do
    namespace :v1 do
      post "signup", to: "auth#signup"
      post "login", to: "auth#login"
      resources :appointments, only: [ :create ]
      resources :payments, only: [ :create ]
      resources :prescriptions, only: [ :create ]
    end
  end
end
