# frozen_string_literal: true

Rails.application.routes.draw do
  authenticated :user do
    root to: 'posts#index', as: :authenticated_root
  end
  root to: "users#show"
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :posts, only: %i[index new create]
end
