Rails.application.routes.draw do
  
  get 'orders/index'

  get 'orders/show'

  get 'orders/create'

  get 'orders/edit'

  get 'orders/update'

  root to: 'products#index'

  get "/vendors", to: "vendors#index"
  get "/vendors/:id", to: "vendors#show", as: "vendor"

  resources :categories do
    resources :products, only: [:index]
  end

  resources :products
end
