class Comment < ApplicationRecord
  include Voteable

  belongs_to :post
  belongs_to :user
end
