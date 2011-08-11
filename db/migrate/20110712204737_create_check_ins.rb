class CreateCheckIns < ActiveRecord::Migration
  def self.up
    create_table :check_ins do |t|
      t.integer :venue_id
      t.integer :user_id
      t.datetime :in_time
      t.datetime :out_time
      t.integer :current_event_invite_id
      t.integer :itinerary_invite_id

      t.timestamps
    end
  end

  def self.down
    drop_table :check_ins
  end
end
