Rails.application.routes.draw do
  # get 'static_pages/landing_page'
  # get 'static_pages/dashboard'
  devise_for :users
  root 'users#index'
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :new, :show, :create, :destroy]
  end

  resources :posts do
    resources :comments, only: [:create, :destroy]
    resources :likes, only: [:create]
  end
end
