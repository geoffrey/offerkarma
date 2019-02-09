# frozen_string_literal: true

class Offer < ApplicationRecord
  belongs_to :company
  belongs_to :user

  has_many :votes
  has_many :comments

  before_create :set_default_values

  validates :status, inclusion: { in: %w[pending accepted rejected] }
  validates :position, presence: true

  def status_class
    return "success" if status == "accepted"
    return "danger" if status == "rejected"

    "info"
  end

  def views
    rand(10_000)
  end

  def tc
    base_salary.to_i + signon_bonus.to_i
  end

  def accept!
    self.status = "accepted"
    save!
  end

  def reject!
    self.status = "rejected"
    save!
  end

  private

  def set_default_values
    self.status ||= "pending"
  end
end
