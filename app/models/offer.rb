class Offer < ApplicationRecord
  belongs_to :company
  has_many :votes
  has_many :comments
end
