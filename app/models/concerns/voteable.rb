module Voteable
  extend ActiveSupport::Concern

  included do
    after_create :add_default_upvote

    has_many :votes, as: :voteable
  end

  private

  def add_default_upvote
    Vote.create(voteable: self, user:, value: 1)
  end
end