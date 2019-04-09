class CreateReferrals < ActiveRecord::Migration[5.2]
  def change
    create_table :referrals do |t|
      t.uuid :uuid, default: -> { "gen_random_uuid()" }
      t.bigint :user_id
      t.bigint :referrer_id
      t.bigint :company_id
      t.string :position
      t.string :location
      t.boolean :referred
      t.datetime :referred_at
      t.timestamps
    end

    add_index :referrals, :user_id
    add_index :referrals, :referrer_id
    add_index :referrals, :company_id
  end
end
