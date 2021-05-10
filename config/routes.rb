# frozen_string_literal: true

Rails.application.routes.draw do
  authenticated :user do
    root to: 'news_feeds#show', as: :authenticated_root
  end
  root to: "users#show"
  devise_for :users, controllers: { registrations: 'registrations', omniauth_callbacks: "users/omniauth_callbacks" }
  get 'newsfeed', action: :show, controller: 'news_feeds'
  resources :users, only: %i[index show new create edit update]
  resources :friendship_requests, only: %i[new create edit update destroy]
  resources :notifications, only: %i[index]
  resources :posts, only: %i[new create show] do
    resources :comments, only: %i[new create], module: :posts
    resources :likes, only: %i[new create], module: :posts
  end
  resources :photos, only: %i[new create show] do
    resources :comments, only: %i[new create], module: :photos
    resources :likes, only: %i[new create], module: :photos
  end
end
