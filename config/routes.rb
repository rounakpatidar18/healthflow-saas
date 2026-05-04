require "sidekiq/web"

Rails.application.routes.draw do
  root "home#index"
  get "home/index"
  mount Rswag::Ui::Engine => "/api-docs"
  mount Rswag::Api::Engine => "/api-docs"
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

  get "*path", to: "home#index", constraints: lambda { |req|
    !req.path.start_with?("/api/", "/api-docs", "/sidekiq") && req.format.html?
  }
end
