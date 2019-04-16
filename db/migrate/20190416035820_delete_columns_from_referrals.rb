class DeleteColumnsFromReferrals < ActiveRecord::Migration[5.2]
  def change
    remove_column :referrals, :last_name, :string
    remove_column :referrals, :first_name, :string
  end
end
