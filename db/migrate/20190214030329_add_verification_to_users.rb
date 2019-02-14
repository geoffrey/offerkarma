class AddVerificationToUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :confirmed_at, :datetime
    add_column :users, :verification_digest, :string
    add_column :users, :verified_at, :datetime
  end
end
