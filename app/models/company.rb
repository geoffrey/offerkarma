# frozen_string_literal: true

class Company < ApplicationRecord
  before_save { url.downcase! }
  before_save { name.downcase! }

  validates :name, :url, presence: true

  has_many :offers
end
