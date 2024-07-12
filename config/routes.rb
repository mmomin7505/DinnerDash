Rails.application.routes.draw do
  namespace :admin do
    resources :dashboards, only: [:index]
    resources :items
    resources :orders do
      member do
        get "paid_order"
        get "complete_order"
        get "cancel_order"
      end
    end
    resources :categories do
      member do
        post "remove_item"
      end
    end
  end
  resources :items, only: [:index]
  resource :cart, only: [:show]
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }
  resources :categories, only: [:show]
  resources :orders, only: [:index]
  resources :cart_items, only: [:create, :destroy, :update] do
    collection do
      get 'checkout'
    end
  end
  root 'items#index'
end
