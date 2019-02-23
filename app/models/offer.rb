# frozen_string_literal: true

class Offer < ApplicationRecord
  include OfferCreation

  is_impressionable

  attr_accessor :company_name

  belongs_to :company
  belongs_to :user

  has_many :votes, dependent: :destroy
  has_many :upvotes, -> { up }, class_name: "Vote"
  has_many :downvotes, -> { down }, class_name: "Vote"

  has_many :comments, dependent: :destroy

  validates :base_salary, :signon_bonus, :relocation_package,
            inclusion: 0..10_000_000, allow_nil: true
  validates :bonus_per_year_percent, inclusion: 0..100, allow_nil: true
  validates :stock_strike_price, inclusion: 0..1_000, allow_nil: true
  validates :stock_fair_market_value, inclusion: 0..10_000, allow_nil: true
  validates :stock_count, inclusion: 0..2_000_000, allow_nil: true
  validates :yoe, inclusion: 0..50, allow_nil: true

  scope :accepted, -> { where(status: :accepted) }
  scope :pending, -> { where(status: :pending) }
  scope :declined, -> { where(status: :declined) }

  enum scope: %i[public_scope private_scope]
  enum status: %i[accepted declined pending]
  enum stock_type: %i[options rsus]

  default_value_for(:scope) { :public_scope }
  default_value_for(:status) { :pending }
  default_value_for(:stock_type) { :options }

  def views
    impressions.size
  end

  def status_class
    return "success" if accepted?
    return "danger" if declined?

    "info"
  end

  def bonus_value_per_year
    bonus_per_year_percent.to_f * base_salary.to_f / 100
  end

  def stocks_liquid?
    company.public?
  end

  def stock_fair_market_value
    company&.quote || read_attribute(:stock_fair_market_value)
  end

  def stock_profit
    if options?
      stock_fair_market_value.to_f - stock_strike_price.to_f
    else
      stock_fair_market_value.to_f
    end
  end

  def stocks_profit
    stock_profit.to_f * stock_count.to_f
  end

  def stocks_profit_per_year
    stocks_profit.to_f / 4
  end

  def tc
    base_salary.to_i +
      stocks_profit_per_year.to_f +
      bonus_value_per_year.to_f
  end
end
