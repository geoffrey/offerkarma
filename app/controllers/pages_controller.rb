# frozen_string_literal: true

class PagesController < ApplicationController
  def index
    @offers = Offer.includes(
      :company,
      :votes,
      :comments,
      :impressions
    ).last(10)
  end

  def equity
  end

  def referrals
  end

  def negotiate
  end
end
