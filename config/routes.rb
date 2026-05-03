require "sidekiq/web"

Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq"
  get "/health", to: proc { [ 200, {}, [ "OK" ] ] }
  namespace :api do
    namespace :v1 do
      post "signup", to: "auth#signup"
      post "login", to: "auth#login"
      get "reports/revenue"
      get "reports/patient_visits"
      get "reports/medicine_usage"
      resources :appointments, only: [ :create ]
      resources :payments, only: [ :create ]
      resources :prescriptions, only: [ :create ]
    end
  end
end
