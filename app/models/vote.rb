# frozen_string_literal: true

class Vote < ApplicationRecord
  belongs_to :offer
  belongs_to :user

  validates :offer, uniqueness: { scope: :user }

  enum vote: %i[up down]

  default_value_for(:vote) { :up }
end
