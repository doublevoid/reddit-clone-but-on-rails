class Entry < ApplicationRecord
  belongs_to :user
  has_many :votes

  after_create :add_vote

  scope :with_entryables, -> { includes(:entryable) }
  delegated_type :entryable, types: %w[Comment Post]

  private

  def add_vote
    Vote.create(entry: self, user:, value: 1)
  end
end
