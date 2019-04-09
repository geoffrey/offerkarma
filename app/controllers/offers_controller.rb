# frozen_string_literal: true

class OffersController < ApplicationController
  before_action :redirect_to_login_if_needed, except: %i[show index]
  before_action :set_offer, only: %i[show votes comments]
  before_action :set_own_offer, only: %i[edit update destroy]

  def index
    @offers = Offer.filter(filters: offer_filters).page(params[:page])
  end

  def show
    impressionist @offer
    @comments = @offer.comments.includes(:user)
  end

  def new
    @offer = current_user.offers.new(read_offer_params_from_session)
    @offer.current_step = session[:offer_step]
  end

  def edit; end

  def create
    save_offer_params_in_session(offer_params)
    @offer = current_user.offers.new(read_offer_params_from_session)
    @offer.current_step = session[:offer_step]

    if @offer.first_step?
      create_company!
      save_offer_params_in_session(company_id: @offer.company_id)
    end

    if @offer.valid?
      if params[:back_button]
        @offer.previous_step
      elsif @offer.last_step?
        @offer.save if @offer.all_valid?
      else
        @offer.next_step
      end
      session[:offer_step] = @offer.current_step
    end

    if @offer.new_record?
      redirect_to new_offer_path
    else
      reset_offer_session
      redirect_to offer_path @offer.reload.uuid
    end
  end

  def update
    @offer.update! offer_params
    redirect_to offer_path @offer.uuid
  end

  def destroy
    @offer.destroy!
    redirect_to account_path
  end

  def votes
    vote = @offer.votes.find_or_create_by!(user: current_user)

    if vote.vote == params[:vote].to_i
      vote.delete
    else
      vote.vote = params[:vote]
      vote.save!
    end

    redirect_to offer_path @offer.uuid
  end

  def comments
    @comment = @offer.comments.new(comment_params)
    @comment.user = current_user
    @comment.save!
    redirect_to offer_path @offer.uuid, anchor: "comment"
  end

  private

  def save_offer_params_in_session(p)
    session[:offer_params] ||= {}
    session[:offer_params].deep_merge! p
  end

  def read_offer_params_from_session
    session[:offer_params] || {}
  end

  def reset_offer_session
    session[:offer_step] = session[:offer_params] = nil
  end

  def create_company!
    @offer.company = Company.find_or_create_from_clearbit!(
      offer_company_params[:company_name]
    )
  end

  def set_own_offer
    @offer = current_user.offers.find_by_uuid!(params[:id])
  end

  def set_offer
    @offer = Offer.find_by_uuid!(params[:id])
  end

  def vote_params
    params.permit(:vote)
  end

  def comment_params
    params.require(:comment).permit(:text)
  end

  def offer_company_params
    params.require(:offer).permit(:company_name)
  end

  def offer_filters
    params.permit(:company, :location, :position, :status, :level, :yoe)
  end

  def offer_params
    attrs = params.require(:offer).permit(
      :base_salary,
      :bonus_per_year_percent,
      :company_name,
      :level,
      :location,
      :notes,
      :position,
      :relocation_package,
      :signon_bonus,
      :stock_count,
      :stock_preferred_price,
      :stock_grant_value,
      :stock_strike_price,
      :stock_type,
      :status,
      :yoe
    )

    attrs[:base_salary] = Monetize.parse(attrs[:base_salary]).amount if attrs[:base_salary].present?
    attrs[:relocation_package] = Monetize.parse(attrs[:relocation_package]).amount if attrs[:relocation_package].present?
    attrs[:signon_bonus] = Monetize.parse(attrs[:signon_bonus]).amount if attrs[:signon_bonus].present?
    attrs[:stock_grant_value] = Monetize.parse(attrs[:stock_grant_value]).amount if attrs[:stock_grant_value].present?

    attrs
  end
end
