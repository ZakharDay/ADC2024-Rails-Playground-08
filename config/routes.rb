Rails.application.routes.draw do
  resources :galleries do
    resources :gallery_images, only: :create
  end

  resources :gallery_images, only: :destroy do
    member do
      get :lower
      get :higher
    end
  end

  get "cart/add/:id", to: "carts#add", as: "cart_add"
  get "cart/destroy", to: "carts#destroy", as: "cart_destroy"

  resources :products
  resources :publications

  get "likes/toggle"

  devise_for :users

  namespace :api, format: 'json' do
    namespace :v1 do
      resources :pins, only: [:index, :show, :create]
      get "welcome/index"

      devise_scope :user do
        post "sign_up", to: "registrations#create"
        post "sign_in", to: "sessions#create"
        post "sign_out", to: "sessions#destroy"
      end
    end
  end

  resources :profiles

  resources :pins do
    resources :comments

    collection do
      get "most_liked"
    end

    get "/by_tag/:tag", to: "pins#by_tag", on: :collection, as: "tagged"
  end

  get "welcome/index"
  get "welcome/dice"
  
  get  "search", to: "welcome#search", as: "welcome_search"
  # post "search", to: "welcome#search", as: "welcome_search_page"
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "welcome#index"
end
