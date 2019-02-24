class RemoveConfirmationDigestFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :confirmation_digest, :string
  end
end
