class AddColumnsToReferrals < ActiveRecord::Migration[5.2]
  def change
    add_column :referrals, :yoe, :integer
    add_column :referrals, :job_posting_url, :string
    add_column :referrals, :linkedin_profile_url, :string
    add_column :referrals, :first_name, :string
    add_column :referrals, :last_name, :string
    add_column :referrals, :phone, :string
    add_column :referrals, :email, :string
  end
end
