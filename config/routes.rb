Rails.application.routes.draw do
  devise_for :users
 
  
  root "home#index"
  resources :games
  # mount ActionCable.server => '/cable'

  resources :home, only: :index
  get "contact", to: "home#contact_new"
  post "contact", to: "home#contact_create"
  
end
