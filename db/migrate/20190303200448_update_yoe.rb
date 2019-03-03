class UpdateYoe < ActiveRecord::Migration[5.2]
  def change
    change_column :offers, :yoe, :integer
  end
end
