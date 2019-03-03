class AddVestingScheduleToCompanies < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :vesting_schedule, :integer
  end
end
