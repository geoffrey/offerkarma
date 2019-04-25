# frozen_string_literal: true

class ReferralsController < ApplicationController
  before_action :redirect_to_login_if_needed, except: %i[index show]
  before_action :set_referral, only: %i[show update]
  before_action :set_own_referral, only: %i[edit destroy]

  def index
    @referrals = Referral.filter(filters: referral_filters).page(params[:page])
    @companies = Company.joins(:users)
      .group('companies.id')
      .having('count(company_id) > 0')
      .sample(6)
  end

  def show
  end

  def new
    @last_referral = current_user.referrals.last
    @referral = current_user.referrals.new(read_referral_params_from_session)
    @referral.current_step = session[:referral_step]
  end

  def edit; end

  def create
    save_referral_params_in_session(referral_params)
    @referral = current_user.referrals.new(read_referral_params_from_session)
    @referral.current_step = session[:referral_step]

    if @referral.first_step?
      create_company!
      save_referral_params_in_session(company_id: @referral.company_id)
    end

    if @referral.valid?
      if params[:back_button]
        @referral.previous_step
      elsif @referral.last_step?
        @referral.save if @referral.all_valid?
      else
        @referral.next_step
      end
      session[:referral_step] = @referral.current_step
    end

    if @referral.new_record?
      redirect_to new_referral_path
    else
      reset_referral_session
      redirect_to referral_path @referral.reload.uuid
    end
  end

  def update
    @referral.update! referral_params
    redirect_to referral_path @referral.uuid
  end

  def destroy
    @referral.destroy!
    redirect_to referrals_path
  end

  private

  def create_company!
    @referral.company = Company.find_or_create_from_clearbit!(
      referral_company_params[:company_name]
    )
  end

  def save_referral_params_in_session(p)
    session[:referral_params] ||= {}
    session[:referral_params].deep_merge! p
  end

  def read_referral_params_from_session
    session[:referral_params] || {}
  end

  def reset_referral_session
    session[:referral_step] = session[:referral_params] = nil
  end

  def referral_company_params
    params.require(:referral).permit(:company_name)
  end

  def referral_filters
    params.permit(:company, :yoe)
  end

  def set_referral
    @referral = Referral.find_by_uuid!(params[:id])
  end

  def set_own_referral
    @referral = current_user.referrals.find_by_uuid!(params[:id])
  end

  def referral_params
    params.require(:referral).permit(
      :company_name,
      :email,
      :job_posting_url,
      :linkedin_profile_url,
      :location,
      :position,
      :referrer_id,
      :yoe
    )
  end
end
