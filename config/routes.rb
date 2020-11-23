Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :shops, only: [:show]

  resources :products, only: [:index, :show]

  resources :order_lines, only: [:create, :update, :destroy]

  resource :cart, only: [:show]

  resources :orders, only: [:edit, :update, :show] do
    member do
      get :itinerary
    end
  end

  resources :dashboard, only: [:show]
end
