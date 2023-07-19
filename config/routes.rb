require 'sidekiq/web'
Rails.application.routes.draw do
  devise_for :users
  
  root "home#index"
  
  resources :games do
    member do
      delete 'destroy_all_users', to: 'games#destroy_all_users'
    end
  end

  resources :home, only: :index
  get "contact", to: "home#contact_new"
  post "contact", to: "home#contact_create"

  resources :chats
  resources :messages, only: [:index, :create] do
    collection do
      get :new_chat
    end
  end
 
  resources :aimages

  resources :sounds


  mount Sidekiq::Web => "/sidekiq"
end
