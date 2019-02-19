# frozen_string_literal: true

class EmailsController < ApplicationController
  def show
    # TODO
    @unsubscribed =  false
  end

  def update
    # TODO
    redirect_to unsubscribe_url(email: params[:email])
  end
end
