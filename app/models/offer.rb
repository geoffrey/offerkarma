class Offer < ApplicationRecord
  belongs_to :company
  belongs_to :user

  has_many :votes
  has_many :comments

  def job_offer_type_class
    return "success" if status == :accepted
  	return "danger" if status == :rejected
  	"info"
  end

  def views
  	rand(800)
  end

  def tc
  	base_salary.to_i + signon_bonus.to_i
  end
end
