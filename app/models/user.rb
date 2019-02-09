# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  before_save { email.downcase! }

  validates :password, length: { minimum: 6 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }

  has_many :offers
  has_many :comments
  has_many :votes

  def current_company
    id = current_company_id || Company::REFFO_COMPANY_ID
    @current_company ||= Company.find(id)
  end

  private

  def set_current_company_id
    company_domain = email.split("@").last
    url = "https://autocomplete.clearbit.com/v1/companies/suggest?query=#{company_domain}"
    response = HTTParty.get(url)

    return unless response.success?

    companies = JSON.parse(response.body)
    first_company = companies.first

    return unless first_company

    c = Company.find_or_create_by!(url: first_company["domain"]) do |company|
      company.name = first_company["name"]
    end

    self.current_company_id = c.id
  end
end
