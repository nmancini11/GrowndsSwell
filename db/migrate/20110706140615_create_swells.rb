class CreateSwells < ActiveRecord::Migration
  def self.up
    create_table :swells do |t|
      t.string :name
      t.string :deal_info
      t.datetime :start_date
      t.datetime :end_date
      t.integer :radius
      t.integer :limit
      t.integer :swell_venue_id

      t.timestamps
    end
  end

  def self.down
    drop_table :swells
  end
end
