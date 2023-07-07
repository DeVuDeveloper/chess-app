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
 
  resources :images

  post '/midi', to: 'midi#create', as: 'midi'
  get '/midi/play', to: 'midi#play', as: 'midi_play'
  post '/midi/play', to: 'midi#play'

  mount Sidekiq::Web => "/sidekiq"
end
