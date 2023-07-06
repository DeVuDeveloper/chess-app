require 'sidekiq/web'
Rails.application.routes.draw do
  devise_for :users
 
  
  root "home#index"
  resources :games

  resources :home, only: :index
  get "contact", to: "home#contact_new"
  post "contact", to: "home#contact_create"

  resources :chats
  resources :messages, only: [:index, :create] do
    collection do
      get :new_chat
    end
  end
 
  get '/dist/onig.wasm', to: redirect('/shiki/onig.wasm')

  # Ruta za nord.json datoteku
  get '/themes/nord.json', to: redirect('/shiki/themes/nord.json')

  mount Sidekiq::Web => "/sidekiq"
end
