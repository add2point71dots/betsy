Rails.application.routes.draw do

  get "/vendors", to: "vendors#index"
  get "/vendors/:id", to: "vendors#show", as: "vendor"

  get '/products', to: "products#index"
end
