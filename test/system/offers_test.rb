require "application_system_test_case"

class OffersTest < ApplicationSystemTestCase
  setup do
    @offer = offers(:one)
  end

  test "visiting the index" do
    visit offers_url
    assert_selector "h1", text: "Offers"
  end

  test "creating a Offer" do
    visit offers_url
    click_on "New Offer"

    fill_in "Accepted", with: @offer.accepted
    fill_in "Base salary", with: @offer.base_salary
    fill_in "Bonus per year amount", with: @offer.bonus_per_year_amount
    fill_in "Bonus per year percent", with: @offer.bonus_per_year_percent
    fill_in "Comments enabled", with: @offer.comments_enabled
    fill_in "Company", with: @offer.company_id
    fill_in "Notes", with: @offer.notes
    fill_in "Public", with: @offer.public
    fill_in "Relocation package", with: @offer.relocation_package
    fill_in "Signon bonus", with: @offer.signon_bonus
    fill_in "Votes enabled", with: @offer.votes_enabled
    click_on "Create Offer"

    assert_text "Offer was successfully created"
    click_on "Back"
  end

  test "updating a Offer" do
    visit offers_url
    click_on "Edit", match: :first

    fill_in "Accepted", with: @offer.accepted
    fill_in "Base salary", with: @offer.base_salary
    fill_in "Bonus per year amount", with: @offer.bonus_per_year_amount
    fill_in "Bonus per year percent", with: @offer.bonus_per_year_percent
    fill_in "Comments enabled", with: @offer.comments_enabled
    fill_in "Company", with: @offer.company_id
    fill_in "Notes", with: @offer.notes
    fill_in "Public", with: @offer.public
    fill_in "Relocation package", with: @offer.relocation_package
    fill_in "Signon bonus", with: @offer.signon_bonus
    fill_in "Votes enabled", with: @offer.votes_enabled
    click_on "Update Offer"

    assert_text "Offer was successfully updated"
    click_on "Back"
  end

  test "destroying a Offer" do
    visit offers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Offer was successfully destroyed"
  end
end
