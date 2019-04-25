class AddColumnsToReferralModel < ActiveRecord::Migration[5.2]
  def change
    add_column :referrals, :unlocked_at, :datetime
    add_column :referrals, :referrer_referred_at, :datetime
    add_column :referrals, :referee_referred_at, :datetime
  end
end
