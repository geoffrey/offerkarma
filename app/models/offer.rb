# frozen_string_literal: true

class Offer < ApplicationRecord
  belongs_to :company
  belongs_to :user

  has_many :votes, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :status, inclusion: { in: %w[pending accepted rejected] }
  validates :position, presence: true
  validates :base_salary, :bonus_per_year_amount, :signon_bonus, :relocation_package,
            inclusion: 100..10_000_000
  validates :bonus_per_year_percent, inclusion: 0..100
  validates :yoe, inclusion: 0..99

  enum status: %i[accepted rejected pending]

  default_value_for(:status) { :pending }

  def status_class
    return "success" if accepted?
    return "danger" if rejected?

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
end
