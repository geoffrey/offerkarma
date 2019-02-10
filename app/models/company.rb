# frozen_string_literal: true

class Company < ApplicationRecord
  has_many :offers, dependent: :destroy

  validates :name, :url, presence: true
  validates :url, url: true
  validates :current_valuation, :last_funding_round, inclusion: 100..100_000_000_000

  before_save { url.downcase! }
  before_save { name.downcase! }
end
