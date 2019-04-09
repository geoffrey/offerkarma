# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  belongs_to :company, optional: true
  has_many :referrals

  attr_accessor :verification_token

  validates :password, length: { minimum: 6 }, if: :setting_password?
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }

  has_many :offers, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy

  before_save { email.downcase! }
  before_create :create_verification_digest

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

  def username
     read_attribute(:username) || uuid.first(8)
  end

  def upvoted?(offer)
    offer.upvotes.where(user: self).exists?
  end

  def downvoted?(offer)
    offer.downvotes.where(user: self).exists?
  end

  def uses_corporate_email?
    !!find_company
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def verified?
    !!verified_at
  end

  def verify!
    self.company = find_company
    self.verification_digest = nil
    self.verified_at = DateTime.now
    save!
  end

  private

  def setting_password?
    password || password_confirmation
  end

  def find_company
    Company.find_or_create_from_clearbit!(email_domain)
  end

  def email_domain
    email.split("@").last
  end

  def create_verification_digest
    self.verification_token = User.new_token
    self.verification_digest = User.digest(self.verification_token)
  end
end
