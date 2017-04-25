Rails.application.routes.draw do

  root to: 'products#index'

  get "/vendors", to: "vendors#index"
  get "/vendors/:id", to: "vendors#show", as: "vendor"

  post "/reviews", to: "reviews#create"

  resources :orders, only:[:show, :edit, :update]
  get "/cart", to: "orders#show_cart", as: "cart"
  get "/confirmation", to: "orders#confirm", as: "confirm"

  resources :orderitems, only:[:create, :update, :destroy]

  get "/auth/google_oauth2/callback", to: "sessions#create"
  delete "/logout", to: "sessions#logout", as: "logout"

  resources :categories do
    resources :products, only: [:index]
  end

  resources :vendors do
    resources :products, only: [:index]
  end

  resources :products
  resources :reviews
end
