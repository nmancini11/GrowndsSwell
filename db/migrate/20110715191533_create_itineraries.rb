class CreateItineraries < ActiveRecord::Migration
  def self.up
    create_table :itineraries do |t|
      t.string :name
      t.datetime :start_date
      t.text :summary
      t.integer :venue_id

      t.timestamps
    end
  end

  def self.down
    drop_table :itineraries
  end
end
