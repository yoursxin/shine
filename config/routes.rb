Rails.application.routes.draw do
  devise_for :users
  root 'dashboard#index'
  resources :customers, only: [:index, :show]
  get 'angular_test', to: "angular_test#index"
  get 'faking_billing', to: "fake_billing#show"
 end
