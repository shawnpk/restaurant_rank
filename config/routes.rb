Rails.application.routes.draw do
  devise_for :users

  resources :restaurants do
    resources :reviews, except: [:show, :index]
  end

  root 'restaurants#index'
  get 'pages/about', to: 'pages#about'
  get 'pages/contact', to: 'pages#contact'


end
