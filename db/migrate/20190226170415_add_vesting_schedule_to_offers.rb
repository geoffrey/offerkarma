class AddVestingScheduleToOffers < ActiveRecord::Migration[5.2]
  def change
    add_column :offers, :vesting_schedule, :integer
  end
end
