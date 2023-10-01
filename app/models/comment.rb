class Comment < ApplicationRecord
  include Voteable

  belongs_to :post
  belongs_to :user

  def karma
    votes.sum(:value)
  end
end
