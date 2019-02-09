# frozen_string_literal: true

require "test_helper"

class OffersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @offer = offers(:one)
  end

  test "should get index" do
    get offers_url
    assert_response :success
  end

  test "should get new" do
    get new_offer_url
    assert_response :success
  end

  test "should create offer" do
    assert_difference("Offer.count") do
      post offers_url, params: { offer: { accepted: @offer.accepted, base_salary: @offer.base_salary, bonus_per_year_amount: @offer.bonus_per_year_amount, bonus_per_year_percent: @offer.bonus_per_year_percent, comments_enabled: @offer.comments_enabled, company_id: @offer.company_id, notes: @offer.notes, public: @offer.public, relocation_package: @offer.relocation_package, signon_bonus: @offer.signon_bonus, votes_enabled: @offer.votes_enabled } }
    end

    assert_redirected_to offer_url(Offer.last)
  end

  test "should show offer" do
    get offer_url(@offer)
    assert_response :success
  end

  test "should get edit" do
    get edit_offer_url(@offer)
    assert_response :success
  end

  test "should update offer" do
    patch offer_url(@offer), params: { offer: { accepted: @offer.accepted, base_salary: @offer.base_salary, bonus_per_year_amount: @offer.bonus_per_year_amount, bonus_per_year_percent: @offer.bonus_per_year_percent, comments_enabled: @offer.comments_enabled, company_id: @offer.company_id, notes: @offer.notes, public: @offer.public, relocation_package: @offer.relocation_package, signon_bonus: @offer.signon_bonus, votes_enabled: @offer.votes_enabled } }
    assert_redirected_to offer_url(@offer)
  end

  test "should destroy offer" do
    assert_difference("Offer.count", -1) do
      delete offer_url(@offer)
    end

    assert_redirected_to offers_url
  end
end
