Rails.application.routes.draw do

  devise_for :users
  root to: "homes#top"
  get "/about"=>"homes#about"

  resources :posts, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
    resource :favorites, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end
  
  resources :users, only: [:index, :show, :edit, :update] do
    member do
      get :favorites
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
