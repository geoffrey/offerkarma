# frozen_string_literal: true

class Company < ApplicationRecord
  has_many :offers, dependent: :destroy

  validates :name, :domain, presence: true
  validates_uniqueness_of :domain

  before_save { domain.downcase! }
  before_save { name.downcase! }
  before_save { symbol&.upcase! }
  before_save { set_symbol }
  before_save { update_quote }

  CLEARBIT_COMPANY_SEARCH_URL = "https://autocomplete.clearbit.com/v1/companies/suggest"
  ALPHAVANTAGE_BASE_URL = "https://www.alphavantage.co/query?apikey=#{ENV.fetch('ALPHAVANTAGE_API_KEY')}"
  YAHOO_FINANCE_BASE_URL = "https://finance.yahoo.com/quote"

  def quote
    return if symbol.blank?
    update_quote
    save
    reload
    read_attribute(:quote)
  end

  def public?
    symbol.present? && read_attribute(:quote).present?
  end

  def yahoo_finance_url
    "#{YAHOO_FINANCE_BASE_URL}/#{symbol}" if symbol.present?
  end

  def self.find_or_create_from_clearbit!(search)
    search.downcase!
    company = self.find_by_domain(search)
    company ||= self.find_by_name(search)
    return company if company

    clearbit_company = find_on_clearbit(search)
    return nil unless clearbit_company

    company = self.create!(clearbit_company)
    company
  end

  def self.find_on_clearbit(search)
    response = HTTParty.get("#{CLEARBIT_COMPANY_SEARCH_URL}?query=#{search}")
    return nil unless response.success?
    companies = JSON.parse(response.body)
    companies.first&.slice("name", "domain")
  rescue
    nil
  end

  private

  def set_symbol
    self.symbol ||= get_symbol
  end

  def update_quote
    self.quote = get_quote
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
