# frozen_string_literal: true

class PagesController < ApplicationController
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
