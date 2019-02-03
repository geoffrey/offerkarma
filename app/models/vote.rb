class Vote < ApplicationRecord
  belongs_to :offer

  scope :up, -> { where(vote: 1) }
  scope :down, -> { where(vote: -1) }
end
