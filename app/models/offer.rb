class Offer < ApplicationRecord
  belongs_to :company
  has_many :votes
  has_many :comments

  def views
  	rand(800)
  end

  def tc
  	base_salary.to_i + signon_bonus.to_i
  end
end
