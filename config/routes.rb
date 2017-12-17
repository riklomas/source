Rails.application.routes.draw do
  
  # active admin urls
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  # categories controller
  resources :categories
  
  # items controller
  resources :items
  
  # users could sign up multiple times
  resources :users
  
  # users can only make 1 session
  resource :session
  
  # users can only edit 1 account
  resource :account
  
  get "about", to: "pages#about"
  
  root "pages#home"

end
