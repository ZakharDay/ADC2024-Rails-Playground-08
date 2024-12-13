Rails.application.routes.draw do
  resources :publications

  get "like/toggle"

  devise_for :users

  namespace :api, format: 'json' do
    namespace :v1 do
      resources :pins, only: [:index, :show]
      get "welcome/index"
    end
  end

  resources :profiles

  resources :pins do
    resources :comments

    get "/by_tag/:tag", to: "pins#by_tag", on: :collection, as: "tagged"
  end

  get "welcome/index"
  get "welcome/dice"
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
