# frozen_string_literal: true

class Offer < ApplicationRecord
  acts_as_punchable

  belongs_to :company
  belongs_to :user

  has_many :votes, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :position, presence: true
  validates :base_salary, :signon_bonus, :relocation_package,
            inclusion: 100..10_000_000, allow_nil: true
  validates :bonus_per_year_percent, inclusion: 0..100, allow_nil: true
  validates :yoe, inclusion: 0..99, allow_nil: true

  enum scope: %i[public_scope private_scope]
  enum status: %i[accepted rejected pending]
  enum stock_type: %i[option rsus]

  default_value_for(:scope) { :public_scope }
  default_value_for(:status) { :pending }
  default_value_for(:stock_type) { :option }

  def status_class
    return "success" if accepted?
    return "danger" if rejected?

    "info"
  end

  def views
    hits
  end

  def stock_value
    stock_count.to_i * stock_fair_market_value.to_i
  end

  def stock_cost
    stock_count.to_i * stock_strike_price.to_i
  end

  def tc
    base_salary.to_i + signon_bonus.to_i + stock_value.to_i - stock_cost.to_i
  end
end
