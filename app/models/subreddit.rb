class Subreddit < ApplicationRecord
  has_many :user_subscriptions
  has_many :users, through: :user_subscriptions

  has_many :subreddit_moderators
  has_many :moderators, foreign_key: 'subreddit_id', class_name: 'SubredditModerator',
           through: :subreddit_moderators
end
