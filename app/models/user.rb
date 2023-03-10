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

  def karma
    karma = User.joins('LEFT JOIN posts on posts.user_id = users.id')
                .joins('LEFT JOIN comments on posts.user_id = users.id')
                .joins("LEFT JOIN votes AS c_votes on c_votes.voteable_type = 'Post' AND c_votes.voteable_id = posts.id")
                .joins("LEFT JOIN votes AS p_votes on p_votes.voteable_type = 'Comment' AND p_votes.voteable_id = comments.id")
                .select('SUM(c_votes.value) AS comment_votes, SUM(p_votes.value) AS post_votes')[0]

    karma['comment_votes'].to_i + karma['post_votes'].to_i
  end
end
