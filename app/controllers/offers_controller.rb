# frozen_string_literal: true

class OffersController < ApplicationController
  before_action :redirect_to_login_if_needed, only: %i[index show]
  before_action :set_offer, only: %i[show vote comments]
  before_action :set_own_offer, only: %i[edit update destroy]

  # GET /offers
  def index
    @offers = Offer.includes(:company, :votes, :comments).last(10)
  end

  # GET /offers/1
  def show
    @offer.punch(request)
  end

  # GET /offers/new
  def new
    @offer = Offer.new
  end

  # GET /offers/1/edit
  def edit; end

  # POST /offers
  def create
    @offer = Offer.new(offer_params)

    if @offer.save
      redirect_to @offer
    else
      render :new
    end
  end

  # PATCH/PUT /offers/1
  def update
    if @offer.update(offer_params)
      redirect_to @offer
    else
      render :edit
    end
  end

  # DELETE /offers/1
  def destroy
    @offer.destroy
    edirect_to offers_url, notice: "Your offer was successfully destroyed."
  end

  # POST /offers/:id/votes
  def vote
    vote = @offer.votes.find_or_create_by!(user: current_user)

    if vote.vote == params[:vote].to_i
      vote.delete
    else
      vote.vote = params[:vote]
      vote.save!
    end

    redirect_to offer_path @offer.uuid
  end

  # POST /offers/:id/comments
  def comments
    @comment = @offer.comments.new(comment_params)
    @comment.user = current_user
    @comment.save!
    redirect_to offer_path @offer.uuid
  end

  private

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

  # Never trust parameters from the scary internet, only allow the white list through.
  def offer_params
    params.require(:offer).permit(:company_id, :public, :comments_enabled, :votes_enabled, :base_salary, :signon_bonus, :relocation_package, :notes, :bonus_per_year_amount, :bonus_per_year_percent, :accepted)
  end
end
