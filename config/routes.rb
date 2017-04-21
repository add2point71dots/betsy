Rails.application.routes.draw do

     resources :categories do
     resources :books, only: [:index]
     # two ways to get the same nested route
     end

     resources :products

     # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
