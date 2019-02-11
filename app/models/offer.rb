# frozen_string_literal: true

class Offer < ApplicationRecord
  acts_as_punchable

  belongs_to :company
  belongs_to :user

  has_many :votes, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :position, presence: true
  validates :base_salary, :bonus_per_year_amount, :signon_bonus, :relocation_package,
            inclusion: 100..10_000_000, allow_nil: true
  validates :bonus_per_year_percent, inclusion: 0..100, allow_nil: true
  validates :yoe, inclusion: 0..99, allow_nil: true

  enum status: %i[accepted rejected pending]

  default_value_for(:status) { :pending }

  def status_class
    return "success" if accepted?
    return "danger" if rejected?

    "info"
  end

  def views
    hits
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
end
