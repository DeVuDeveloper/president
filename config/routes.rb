Rails.application.routes.draw do
  root "users#index"
  resources :users, only: [:index, :show] do
    resources :posts, only: %i[index new create show destroy]
  end

  resources :posts do
    resources :comments, only: %i[create]
    resources :likes, only: %i[create]
  end
end