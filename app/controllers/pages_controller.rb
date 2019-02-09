# frozen_string_literal: true

class PagesController < ApplicationController
  before_action :redirect_to_offers_if_logged_in, only: %i[index]

  def index
    @offers = Offer.includes(:company, :votes, :comments).last(10)
  end

  def stocks
  end

  def referrals
  end

  def negotiate
  end
end
