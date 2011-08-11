class CreateVenues < ActiveRecord::Migration
  def self.up
    create_table :venues do |t|
      t.string :name
      t.string :street_address_1
      t.string :street_address_2
      t.string :city
      t.string :state
      t.string :zip
      t.string :country
      t.string :latitude
      t.string :longitude
      t.integer :venue_schedule_id
      t.integer :venue_contact_id

      t.timestamps
    end
  end

  def self.down
    drop_table :venues
  end
end
