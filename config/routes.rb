Rails.application.routes.draw do
  devise_for :users
 
  ActiveAdmin.routes(self)
  root "home#index"


  resources :home, only: :index
  get "contact", to: "home#contact_new"
  post "contact", to: "home#contact_create"
  
end
