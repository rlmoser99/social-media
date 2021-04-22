# frozen_string_literal: true

Rails.application.routes.draw do
  authenticated :user do
    root to: 'posts#index', as: :authenticated_root
  end
  root to: "users#show"
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :posts, only: %i[index new create]
  resources :users, only: %i[index show new create edit update]
  resources :friendship_requests, only: %i[new create edit update destroy]
  resources :notifications, only: %i[index]
  resources :likes, only: %i[new create]
  resources :comments, only: %i[new create]
end
