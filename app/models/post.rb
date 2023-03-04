class Post < ApplicationRecord
  belongs_to :subreddit
  belongs_to :user

  has_many :post_votes
end
