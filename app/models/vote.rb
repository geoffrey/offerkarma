# frozen_string_literal: true

class Vote < ApplicationRecord
  belongs_to :offer
  belongs_to :user

  scope :up, -> { where(vote: 1) }
  scope :down, -> { where(vote: -1) }
end
