# frozen_string_literal: true

class PagesController < ApplicationController
  def index
    @pending_offers = Offer.pending.includes(
      :company,
      :votes,
      :comments,
      :impressions
    ).last(6)

    @companies = Company.joins(:offers)
      .group('companies.id')
      .having('count(company_id) > 0')
      .sample(6)
  end

  def equity
  end

  def referrals
  end

  def negotiate
  end
end
