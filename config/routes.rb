# frozen_string_literal: true

Rails.application.routes.draw do
  resources :comment_votes
  resources :post_votes
  resources :comments
  resources :posts
  resources :subreddits
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
