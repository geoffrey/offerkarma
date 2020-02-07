# frozen_string_literal: true

class Offer < ApplicationRecord
  include Wizard
  include OfferValidations

  attr_accessor :company_name

  belongs_to :company
  belongs_to :user

  has_many :votes, dependent: :destroy
  has_many :upvotes, -> { up }, class_name: "Vote"
  has_many :downvotes, -> { down }, class_name: "Vote"

  has_many :comments, dependent: :destroy

  validates :signon_bonus, :relocation_package,
            inclusion: 0..200_000, allow_nil: true
  validates :base_salary, inclusion: 10_000..10_000_000, allow_nil: true
  validates :stock_grant_value, inclusion: 1_000..10_000_000, allow_nil: true
  validates :bonus_per_year_percent, inclusion: 0..100, allow_nil: true
  validates :stock_strike_price, inclusion: 0..1_000, allow_nil: true
  validates :stock_preferred_price, inclusion: 0..10_000, allow_nil: true
  validates :stock_count, inclusion: 0..5_000_000, allow_nil: true
  validates :yoe, inclusion: 0..50, allow_nil: true

  enum scope: {
    private: 0,
    public:  1
  }, _suffix: true
  default_value_for(:scope) { :public }

  enum status: {
    pending:  0,
    accepted: 1,
    declined: 2
  }
  default_value_for(:status) { :pending }

  enum stock_type: {
    options: 0,
    rsus:    1
  }
  default_value_for(:stock_type) { :options }

  enum vesting_schedule: {
    standard:   0,
    backloaded: 1
  }, _suffix: true
  default_value_for(:vesting_schedule) { :standard }

  after_create :post_on_twitter

  def wizard_steps
    %w[position cash equity misc]
  end

  def self.filter(filters: {}, user: nil)
    offers = user ? user.offers : self
    offers = offers.includes(
      :company,
      :upvotes,
      :downvotes,
      :comments
    )

    if Offer.statuses.keys.to_a.include?(filters[:status]&.downcase)
      offers = offers.where(status: filters[:status].downcase)
    end

    if filters[:company].present?
      company = Company.find_or_create_from_clearbit!(filters[:company])
      offers = offers.where(company_id: company&.id)
    end

    if filters[:yoe].present?
      offers = offers.where(yoe: filters[:yoe])
    end

    if filters[:level].present?
      offers = offers.where("level ILIKE ?", "%#{filters[:level]}%")
    end

    if filters[:position].present?
      offers = offers.where("position ILIKE ?", "%#{filters[:position]}%")
    end

    if filters[:location].present?
      offers = offers.where("location ILIKE ?", "%#{filters[:location]}%")
    end

    offers.order(updated_at: :desc)
  end

  def og_title
    "#{company.display_name}: " \
      "$#{ActionController::Base.helpers.number_to_human(total_compensation)} " \
      "#{money_bags} " \
      "(#{og_elements.join(', ')})"
  end

  def og_description
    "#{og_elements.join(' | ')}.\n" \
      "Go to offerkarma.com to give your feedback on this offer"
  end

  def og_elements
    [position, level, location].reject{ |v| v.blank? }
  end

  def money_bags
    '💰' * (total_compensation / 100_000).clamp(0, 3)
  end

  def self.vesting_schedule_display(vesting_schedule)
    if vesting_schedule == "backloaded"
      "Backloaded vesting (5%, 15%, 40%, 40%)"
    else
      "Standard vesting (25%, 25%, 25%, 25%)"
    end
  end

  def vesting_schedule_display
    Offer.vesting_schedule_display(vesting_schedule.to_s)
  end

  def vesting_breakdown
    if backloaded_vesting_schedule?
      [5, 15, 40, 40]
    else
      [25, 25, 25, 25]
    end
  end

  def status_class
    return "success" if accepted?
    return "danger" if declined?
    "info"
  end

  def bonus_value_per_year
    base_salary.to_i * bonus_per_year_percent.to_i / 100
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

  def stocks_profit_at_year(year = 1)
    return 0 unless [1, 2, 3, 4].include?(year)

    stocks_profit * vested_at_year(year) / 100
  end

  def vested_at_year(year = 1)
    vesting_breakdown[year-1]
  end

  def total_compensation(year = 1)
    return 0 unless [1, 2, 3, 4].include?(year)

    tc = base_salary.to_i +
      stocks_profit_at_year(year).to_i +
      bonus_value_per_year.to_i

    if year == 1
      tc + signon_bonus.to_i + relocation_package.to_i
    else
      tc
    end
  end

  def show_breakdown?
    backloaded_vesting_schedule? ||
      signon_bonus.to_i.positive? ||
      relocation_package.to_i.positive?
  end

  def url
    Rails.application.routes.url_helpers.offer_url(uuid, host: "https://offerkarma.com")
  end

  def post_on_twitter
    return unless Rails.env.production?
    reload
    p "Posting offer on twitter... #{twitter_update}"
    $twitter.update(twitter_update)
  rescue
    nil
  end

  def twitter_update
    "#{og_title} #{url}"
  end
end
