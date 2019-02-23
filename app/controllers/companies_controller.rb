# frozen_string_literal: true

class CompaniesController < ApplicationController
  before_action :set_company, only: %i[show edit update destroy]

  def index
    @companies = Company.all
  end

  def show
    @company.save
    @offers = @company.offers
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_company
    @company = Company.find_by_uuid!(params[:id])
  end

  def company_params
    params.require(:company).permit(:name, :url, :public, :current_valuation, :last_funding_round)
  end
end
