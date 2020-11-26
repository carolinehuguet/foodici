Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :shops, only: [:show]

  resources :products, only: [:index, :show] do
    resources :order_lines, only: [:create]
  end

  resources :order_lines, only: [:update, :destroy] do
    member do
      patch :increase_quantity
      patch :decrease_quantity
    end
  end

  resource :cart, only: [:show]

  resources :orders, only: [:edit, :update, :show] do
    member do
      get :itinerary
    end
  end

  resource :dashboard, only: [:show]
end
