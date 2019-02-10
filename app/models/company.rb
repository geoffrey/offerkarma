# frozen_string_literal: true

class Company < ApplicationRecord
  has_many :offers, dependent: :destroy

  validates :name, :domain, presence: true

  before_save { domain.downcase! }
  before_save { name.downcase! }
end
