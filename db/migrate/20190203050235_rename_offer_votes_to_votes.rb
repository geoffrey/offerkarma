class RenameOfferVotesToVotes < ActiveRecord::Migration[5.2]
  def change
  	rename_table :offer_votes, :votes
  end
end
