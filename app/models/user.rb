# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
  has_many :posts
  has_many :post_votes

  has_many :comments
  has_many :comment_votes

  has_many :user_subscriptions
  has_many :subreddits, through: :user_subscriptions

  has_many :subreddit_moderators
  has_many :moderated_subreddits, foreign_key: 'user_id', class_name: 'SubredditModerator',
           through: :subreddit_moderators

  def karma
    karma = User.joins("LEFT JOIN posts on posts.id = users.id")
                .joins("LEFT JOIN comments on comments.id = users.id")
                .joins("LEFT JOIN post_votes on posts.id = post_votes.id")
                .joins("LEFT JOIN comment_votes on comments.id = comment_votes.id").where(id:)
                .select("SUM(comment_votes.value) AS comment_votes, SUM(post_votes.value) AS post_votes")[0]

    karma["comment_votes"].to_i + karma["post_votes"].to_i
  end
end
