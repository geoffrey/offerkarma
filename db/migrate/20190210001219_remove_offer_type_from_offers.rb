class RemoveOfferTypeFromOffers < ActiveRecord::Migration[5.2]
  def change
    remove_column :offers, :offer_type, :string
  end
end
