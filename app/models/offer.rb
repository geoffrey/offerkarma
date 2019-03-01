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

  validates :signon_bonus, :relocation_package, :stock_grant_value,
            inclusion: 1_000..10_000_000, allow_nil: true
  validates :base_salary, inclusion: 20_000..1_000_000, allow_nil: true
  validates :bonus_per_year_percent, inclusion: 0..100, allow_nil: true
  validates :stock_strike_price, inclusion: 0..1_000, allow_nil: true
  validates :stock_preferred_price, inclusion: 0..10_000, allow_nil: true
  validates :stock_count, inclusion: 0..2_000_000, allow_nil: true
  validates :yoe, inclusion: 0..50, allow_nil: true

  enum scope: %i[public_scope private_scope]
  enum status: %i[accepted declined pending]
  enum stock_type: %i[options rsus]
  enum vesting_schedule: %i[standard backloaded]

  default_value_for(:scope) { :public_scope }
  default_value_for(:status) { :pending }
  default_value_for(:stock_type) { :options }
  default_value_for(:vesting_schedule) { :standard }

  after_create :post_on_twitter

  def views
    impressions.size
  end

  def display_title
    "#{company.display_name}: " \
      "$#{ActionController::Base.helpers.number_to_human(tc)} " \
      "(#{[position, level, location].reject{ |v| v.blank? }.join(', ')})"
  end

  def og_title
    "Offer from #{company.display_name}: " \
      "$#{ActionController::Base.helpers.number_to_human(tc)}" \
  end

  def og_description
    "#{[position, level, location].reject{ |v| v.blank? }.join(' | ')}.\n" \
      "How is this offer?\n" \
      "Give your feedback on reffo.us!"
  end

  def self.vesting_schedule_display(vesting_schedule)
    return "Backloaded (5, 15, 40, 40)" if vesting_schedule == "backloaded"
    "Standard (25, 25, 25, 25)"
  end

  def vesting_schedule_display
    Offer.vesting_schedule_display(vesting_schedule.to_s)
  end

  def status_class
    return "success" if accepted?
    return "danger" if declined?
    "info"
  end

  def bonus_value_per_year
    bonus_per_year_percent.to_i * base_salary.to_i / 100
  end

  def stocks_liquid?
    company.public?
  end

  def stock_preferred_price
    if company&.public?
      company.quote
    else
      read_attribute(:stock_preferred_price)
    end
  end

  def stock_profit
    if options?
      stock_preferred_price.to_i - stock_strike_price.to_i
    else
      stock_preferred_price.to_i
    end
  end

  def stocks_profit
    stock_grant_value || stock_profit.to_i * stock_count.to_i
  end

  def stocks_profit_per_year
    stocks_profit.to_i / 4
  end

  def tc
    base_salary.to_i +
      stocks_profit_per_year.to_i +
      bonus_value_per_year.to_i
  end

  def tc_year_1
    tc +
      signon_bonus.to_i +
      relocation_package.to_i
  end

  def url
    Rails.application.routes.url_helpers.offer_url(uuid, host: "https://reffo.us")
  end

  def post_on_twitter
    return unless Rails.env.production?

    $twitter.update("New offer posted! #{display_title} #{url}")
  rescue
    nil
  end
end
