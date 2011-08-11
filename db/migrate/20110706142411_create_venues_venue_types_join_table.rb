class CreateVenuesVenueTypesJoinTable < ActiveRecord::Migration
  def self.up
    create_table :venues_venue_types, :id => false do |t|
      t.integer :venue_id
      t.integer :venue_type_id
    end
  end

  def self.down
    drop_table :venues_venue_types
  end
end
