# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  attr_accessor :confirmation_token

  validates :password, length: { minimum: 6 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }

  has_many :offers, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy

  before_save { email.downcase! }
  before_create :create_activation_digest

  # TODO: move to a lib
  class << self
    def new_token
      SecureRandom.urlsafe_base64
    end

    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end
  end

  def current_company
    id = current_company_id || Company.first.id
    @current_company ||= Company.find(id)
  end

  def upvoted?(offer)
    offer.votes.up.where(user: self).exists?
  end

  def downvoted?(offer)
    offer.votes.down.where(user: self).exists?
  end

  def confirmed?
    !!confirmed_at
  end

  private

  def set_current_company_id
    company_domain = email.split("@").last
    company = Company.find_or_create_from_clearbit!(company_domain)

    self.current_company_id = company&.id
  end

  def create_activation_digest
    self.confirmation_token = User.new_token
    self.confirmation_digest = User.digest(self.confirmation_token)
  end
end
