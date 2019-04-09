# frozen_string_literal: true

class Company < ApplicationRecord
  has_many :offers, dependent: :destroy
  has_many :users

  validates :name, :domain, presence: true
  validates_uniqueness_of :domain

  enum vesting_schedule: {
    standard:   0,
    backloaded: 1
  }, _suffix: true
  default_value_for(:vesting_schedule) { :standard }

  before_save { domain.downcase! }
  before_save { name.downcase! }
  before_save { symbol&.upcase! }
  before_save { update_symbol }
  before_save { update_quote }

  CLEARBIT_LOGO_BASE_URL   = "https://logo.clearbit.com"
  CLEARBIT_SEARCH_BASE_URL = "https://autocomplete.clearbit.com/v1/companies/suggest"
  ALPHAVANTAGE_BASE_URL    = "https://www.alphavantage.co/query?apikey=#{ENV.fetch('ALPHAVANTAGE_API_KEY')}"
  YAHOO_FINANCE_BASE_URL   = "https://finance.yahoo.com/quote"

  COMPANY_DOMAIN_MAP = {
    "fb.com" => "facebook.com",
  }

  def display_name
    name.humanize
  end

  def logo_url
    "#{CLEARBIT_LOGO_BASE_URL}/#{domain}"
  end

  def public?
    symbol.present? && quote.present?
  end

  def yahoo_finance_url
    "#{YAHOO_FINANCE_BASE_URL}/#{symbol}" if symbol.present?
  end

  def self.find_or_create_from_clearbit!(search)
    search.downcase!
    search = COMPANY_DOMAIN_MAP[search] || search
    company = self.find_by_domain(search)
    company ||= self.find_by_name(search)
    return company if company

    clearbit_company = find_on_clearbit(search)
    return nil unless clearbit_company

    company = self.create(clearbit_company)
    company
  end

  private

  def self.find_on_clearbit(search)
    response = HTTParty.get("#{CLEARBIT_SEARCH_BASE_URL}?query=#{search}")
    return nil unless response.success?
    companies = JSON.parse(response.body)
    companies.first&.slice("name", "domain")
  rescue
    nil
  end

  def update_symbol
    self.symbol ||= get_symbol
  end

  def update_quote
    quote = get_quote
    self.quote = quote if quote
  end

  def get_symbol
    url = "#{ALPHAVANTAGE_BASE_URL}&function=SYMBOL_SEARCH&keywords=#{name}"
    response = HTTParty.get(url)
    return unless response.success?
    body = JSON.parse(response.body)
    body.dig("bestMatches", 0, "1. symbol")
  rescue
    nil
  end

  def get_quote
    url = "#{ALPHAVANTAGE_BASE_URL}&function=GLOBAL_QUOTE&symbol=#{symbol}"
    response = HTTParty.get(url)
    return unless response.success?
    body = JSON.parse(response.body)
    body.dig("Global Quote", "05. price")&.to_f
  rescue
    nil
  end

end
