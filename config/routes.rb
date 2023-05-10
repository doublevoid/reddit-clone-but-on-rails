# frozen_string_literal: true

Rails.application.routes.draw do
  resources :user_subscriptions
  resources :votes
  resources :comments
  resources :posts
  get '/', to: 'subreddits#frontpage'
  get '/r/all', to: 'subreddits#all'
  resources :subreddits, path: 'r', param: :subreddit_name
  resources :user_pages, path: 'u'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#subreddit_posts"
end
