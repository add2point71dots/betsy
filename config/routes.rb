Rails.application.routes.draw do

  root to: 'products#index'

  get "/vendors", to: "vendors#index"
  get "/vendors/:id", to: "vendors#show", as: "vendor"

  resources :orders

  resources :categories do
    resources :products, only: [:index]
  end

  resources :products
end
