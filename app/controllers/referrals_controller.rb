# frozen_string_literal: true

class ReferralsController < ApplicationController
  before_action :redirect_to_login_if_needed, except: %i[show index]
  before_action :set_referral, only: %i[show votes comments]
  before_action :set_own_referral, only: %i[edit update destroy]

  def index
    @referrals = Referral.all
    @companies = Company.joins(:users)
      .group('users.current_company_id')
      .having('count(users.current_company_id) > 0')
      .sample(6)
  end

  def show
  end

  def new
  end

  def edit; end

  def create
  end

  def update
    @referral.update! referral_params
    redirect_to referral_path @referral.uuid
  end

  def destroy
    @referral.destroy!
    redirect_to account_path
  end

  private

  def set_referral
    @referral = Referral.find_by_uuid!(params[:id])
  end

  def referral_params
    params.require(:referral).permit(:company_name, :position, :location)
  end
end
