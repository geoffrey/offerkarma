# frozen_string_literal: true

class Company < ApplicationRecord
  REFFO_COMPANY_ID = 1

  before_save { url.downcase! }
  before_save { name.downcase! }

  validates :name, :url, presence: true

  has_many :offers
end
