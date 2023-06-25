require 'sidekiq/web'
Rails.application.routes.draw do
  devise_for :users
 
  
  root "home#index"
  resources :games

  resources :home, only: :index
  get "contact", to: "home#contact_new"
  post "contact", to: "home#contact_create"

  resources :users do
    resources :chats do
      resources :messages, except: [:index, :show]
    end
  end
 

  mount Sidekiq::Web => "/sidekiq"
end
