# frozen_string_literal: true

Rails.application.routes.draw do
  resources :votes
  resources :comments
  resources :posts
  get '/r/all', to: 'subreddits#all'
  resources :subreddits, path: 'r'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#subreddit_posts"
end
