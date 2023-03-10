class Vote < ApplicationRecord
  validates :user, uniqueness: { scope: %i[voteable_type voteable_id] }
  validates :value, inclusion: { in: [1, -1] }

  belongs_to :voteable, polymorphic: true

  belongs_to :user
end
