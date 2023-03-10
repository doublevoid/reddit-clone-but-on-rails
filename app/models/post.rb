class Post < ApplicationRecord
  include Voteable

  belongs_to :subreddit
  belongs_to :user

  has_many :comments
end
