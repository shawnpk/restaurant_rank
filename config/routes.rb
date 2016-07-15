Rails.application.routes.draw do
  root 'restaurants#index'

  devise_for :users
end
