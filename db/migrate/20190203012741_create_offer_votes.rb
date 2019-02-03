class CreateOfferVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :offer_votes do |t|
      t.references :offer, foreign_key: true
      t.integer :vote

      t.timestamps
    end
  end
end
