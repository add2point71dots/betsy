Rails.application.routes.draw do

  root to: 'products#index'

  get '/vendors/:id/fulfillment', to: 'vendors#fulfillment', as: 'fulfillment'

  get "/vendors", to: "vendors#index"
  get "/vendors/:id", to: "vendors#show", as: "vendor"

  resources :orders, except:[:index, :new, :delete]

  patch 'orderitems/:id/cancel', to: 'orderitems#cancel', as: 'cancel'
  resources :orderitems, except:[:index, :new, :edit]

  resources :categories do
    resources :products, only: [:index]
  end

  resources :vendors do
    resources :products, only: [:index]
  end

  resources :products
  resources :reviews
end
