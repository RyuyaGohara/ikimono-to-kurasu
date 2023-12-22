Rails.application.routes.draw do

  devise_for :users
  root to: "homes#top"
  get "search"=>"searches#search"

  resources :posts, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
    resource :favorites, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end

  resources :users, only: [:index, :show, :edit, :update, :destroy] do
    member do
      get :favorites
    end
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
    resources :notifications, only: [:index]
  end
# DM機能
  resources :messages, only: [:create]
  resources :rooms, only: [:create,:show]

  resources :notifications, only: [:destroy]

  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
