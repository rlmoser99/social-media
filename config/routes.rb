# frozen_string_literal: true

Rails.application.routes.draw do
  root to: "users#show"
  devise_for :users, controllers: { registrations: 'registrations' }
end
