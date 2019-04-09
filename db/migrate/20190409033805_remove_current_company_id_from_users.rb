class RemoveCurrentCompanyIdFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :current_company_id, :bigint
    add_index :users, :company_id
  end
end
