# frozen_string_literal: true

class Referral < ApplicationRecord
  include Wizard
  include ReferralValidations

  belongs_to :user
  belongs_to :company
  belongs_to :referrer, class_name: "User", optional: true

  before_save :update_timestamps

  attr_accessor :company_name

  def wizard_steps
    %w[position candidate]
  end

  def og_title
    "Referral request -  #{company.display_name} " \
    "(#{og_elements.join(', ')})"
  end

  def og_description
    "Go to reffo.us to refer this candidate"
  end

  def og_elements
    [position, location].reject{ |v| v.blank? }
  end

  def self.filter(filters: {}, user: nil)
    referrals = user ? user.referrals : self

    if filters[:company].present?
      company = Company.find_or_create_from_clearbit!(filters[:company])
      referrals = referrals.where(company_id: company&.id)
    end

    if filters[:yoe].present?
      referrals = referrals.where(yoe: filters[:yoe])
    end

    if filters[:position].present?
      referrals = referrals.where("position ILIKE ?", "%#{filters[:position]}%")
    end

    if filters[:location].present?
      referrals = referrals.where("location ILIKE ?", "%#{filters[:location]}%")
    end

    referrals.order(updated_at: :desc)
  end

  private

  def update_timestamps
    if referrer_id_changed?
      if referrer_id.nil?
        self.unlocked_at = nil
      else
        self.unlocked_at = DateTime.now
      end
    end
  end
end
