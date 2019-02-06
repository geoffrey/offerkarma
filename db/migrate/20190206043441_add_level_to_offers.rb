class AddLevelToOffers < ActiveRecord::Migration[5.2]
  def change
    add_column :offers, :level, :string
  end
end
