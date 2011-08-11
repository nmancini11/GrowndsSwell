class CreateSchedules < ActiveRecord::Migration
  def self.up
    create_table :schedules do |t|
      t.datetime :monday_open
      t.datetime :monday_close
      t.datetime :tuesday_open
      t.datetime :tuesday_close
      t.datetime :wednesday_open
      t.datetime :wednesday_close
      t.datetime :thursday_open
      t.datetime :thursday_close
      t.datetime :friday_open
      t.datetime :friday_close
      t.datetime :saturday_open
      t.datetime :saturday_close
      t.datetime :sunday_open
      t.datetime :sunday_close

      t.timestamps
    end
  end

  def self.down
    drop_table :schedules
  end
end
