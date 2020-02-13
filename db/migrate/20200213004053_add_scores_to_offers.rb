class AddScoresToOffers < ActiveRecord::Migration[6.0]
  def change
    add_column :offers, :fairness_score, :integer
    add_column :offers, :competitiveness_score, :integer
  end
end
