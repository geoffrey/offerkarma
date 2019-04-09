# frozen_string_literal: true

class Referral < ApplicationRecord
  belongs_to :user
  belongs_to :referrer
  belongs_to :company

  validates :position, :location, presence: true
end
