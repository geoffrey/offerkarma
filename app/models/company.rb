# frozen_string_literal: true

class Company < ApplicationRecord
  has_many :offers, dependent: :destroy

  validates :name, :domain, presence: true

  before_save { domain.downcase! }
  before_save { name.downcase! }

  CLEARBIT_COMPANY_SEARCH_URL = "https://autocomplete.clearbit.com/v1/companies/suggest"

  def self.find_or_create_from_clearbit!(search)
    search.downcase!
    company = self.find_by_name(search)
    company ||= self.find_by_domain(search)
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
end
