class CreateOfferVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :offer_votes, id: :uuid do |t|
      t.references :offer, type: :uuid, foreign_key: true
      t.integer :vote

      t.timestamps
    end
  end
end
