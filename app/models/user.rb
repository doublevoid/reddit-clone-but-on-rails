# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
  has_many :posts
  has_many :comments

  has_many :user_subscriptions
  has_many :subreddits, through: :user_subscriptions

  has_many :subreddit_moderators
  has_many :moderated_subreddits, foreign_key: 'user_id', class_name: 'SubredditModerator',
           through: :subreddit_moderators
end
