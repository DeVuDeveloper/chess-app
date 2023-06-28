require 'sidekiq/web'
Rails.application.routes.draw do
  devise_for :users
 
  
  root "home#index"
  resources :games

  resources :home, only: :index
  get "contact", to: "home#contact_new"
  post "contact", to: "home#contact_create"

  resources :chats, only: [:index, :create]
  resources :messages, only: [:index, :create]
 
 

  mount Sidekiq::Web => "/sidekiq"
end
