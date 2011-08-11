class RemoveScheduleFromVenues < ActiveRecord::Migration
  def self.up
    remove_column :venues, :schedule
  end

  def self.down
    add_column :venues, :schedule, :string
  end
end
