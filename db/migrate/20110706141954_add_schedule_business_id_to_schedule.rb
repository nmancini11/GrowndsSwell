class AddScheduleBusinessIdToSchedule < ActiveRecord::Migration
  def self.up
    add_column :schedules, :schedule_business_id, :integer
  end

  def self.down
    remove_column :schedules, :schedule_business_id
  end
end
