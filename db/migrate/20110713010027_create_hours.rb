class CreateHours < ActiveRecord::Migration
  def self.up
    create_table :hours do |t|
      t.integer :venue_id
      t.integer :day
      t.time :open_time
      t.time :close_time

      t.timestamps
    end
  end

  def self.down
    drop_table :hours
  end
end
