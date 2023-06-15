Rails.application.routes.draw do
  devise_for :users
 
  
  root "home#index"
  resources :games

  resources :home, only: :index
  get "contact", to: "home#contact_new"
  post "contact", to: "home#contact_create"

  resources :chats, except: :show do
    resources :messages, only: %i[create]
  end
end
