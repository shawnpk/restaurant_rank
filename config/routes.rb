Rails.application.routes.draw do
  devise_for :users

  resources :restaurants do
    resources :reviews, except: [:show, :index]
    collection do
      get 'search'
    end
  end

  root 'restaurants#index'
  get 'pages/about', to: 'pages#about'
  get 'pages/contact', to: 'pages#contact'


end
