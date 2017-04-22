Rails.application.routes.draw do

  root to: 'products#index'

  resources :categories do
    resources :products, only: [:index]
  end

  resources :products

end
