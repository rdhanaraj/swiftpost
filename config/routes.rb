Swiftpost::Application.routes.draw do
  get "orders/show"
  get "orders/edit"
  get "orders/index"
  get "orders/new"
  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users
  resources :orders
end