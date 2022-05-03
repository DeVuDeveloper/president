Rails.application.routes.draw do
  get 'sessions/create'
  devise_for :users
  root "users#index"
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :new, :show, :create, :destroy]
  end

  devise_scope :user do 
    get '/users/sign_out' => 'devise/sessions#destroy' 
  end

  resources :posts do
    resources :comments, only: [:create, :destroy]
    resources :likes, only: [:create]
  end
end