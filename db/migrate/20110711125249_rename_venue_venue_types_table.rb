class RenameVenueVenueTypesTable < ActiveRecord::Migration
  def self.up
    rename_table :venues_venue_types, :venue_types_venues
  end

  def self.down
    rename_table :venue_types_venues, :venues_venue_types
  end
end
