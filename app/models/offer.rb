# frozen_string_literal: true

class Offer < ApplicationRecord
  is_impressionable

  attr_reader :creation_step

  belongs_to :company
  belongs_to :user

  has_many :votes, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :position, presence: true, if: :first_step?
  validates :base_salary, :signon_bonus, :relocation_package,
            inclusion: 0..10_000_000, allow_nil: true
  validates :bonus_per_year_percent, inclusion: 0..100, allow_nil: true
  validates :stock_strike_price, inclusion: 0..1000, allow_nil: true
  validates :stock_fair_market_value, inclusion: 0..1_000, allow_nil: true
  validates :stock_count, inclusion: 0..1_000_000, allow_nil: true
  validates :yoe, inclusion: 0..99, allow_nil: true

  enum scope: %i[public_scope private_scope]
  enum status: %i[accepted rejected pending]
  enum stock_type: %i[options rsus]

  default_value_for(:scope) { :public_scope }
  default_value_for(:status) { :pending }
  default_value_for(:stock_type) { :options }

  def status_class
    return "success" if accepted?
    return "danger" if rejected?

    "info"
  end

  def stocks_liquid?
    rsus? && company.public?
  end

  def views
    impressionist_count
  end

  def stocks_profit
    stock_profit.to_f * stock_count.to_f
  end

  def stock_profit
    stock_fair_market_value.to_f - stock_strike_price.to_f
  end

  def stocks_profit_per_year
    stocks_profit.to_f / 4
  end

  def bonus_value_per_year
    bonus_per_year_percent.to_f * base_salary.to_f / 100
  end

  def tc
    base_salary.to_i +
      stocks_profit_per_year.to_f +
      bonus_value_per_year.to_f
  end

  private

  def first_step
    creation_step == 1
  end
end
