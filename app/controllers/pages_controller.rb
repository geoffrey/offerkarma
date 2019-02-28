# frozen_string_literal: true

class PagesController < ApplicationController
  skip_before_action :store_return_to

  def index
    @pending_offers = Offer.pending.includes(
      :company,
      :upvotes,
      :downvotes,
      :comments,
      :impressions
    ).last(6).reverse


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
