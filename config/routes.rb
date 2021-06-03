# frozen_string_literal: true

Rails.application.routes.draw do
  authenticated :user do
    root to: 'news_feeds#show', as: :authenticated_root
  end
  root to: "users#show"
  devise_for :users, controllers: { registrations: 'registrations', omniauth_callbacks: "users/omniauth_callbacks" }
  get 'newsfeed', action: :show, controller: 'news_feeds'
  resources :users, only: %i[index show edit update]
  resources :friendship_requests, only: %i[new create edit update destroy]
  resources :notifications, only: %i[index]
  delete 'unlike' => 'likes#destroy', :as => :unlike
  resources :comments, only: %i[show edit update destroy]
  resources :text_posts, only: %i[new create show edit update destroy] do
    resources :comments, only: %i[new create], module: :text_posts
    resources :likes, only: %i[new create], module: :text_posts
  end
  resources :photo_posts, only: %i[new create show edit update destroy] do
    resources :comments, only: %i[new create], module: :photo_posts
    resources :likes, only: %i[new create], module: :photo_posts
  end
end
