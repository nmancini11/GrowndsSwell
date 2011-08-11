class RemoveSwellVenueIdFromSwells < ActiveRecord::Migration
  def self.up
    remove_column :swells, :swell_venue_id
  end

  def self.down
    add_column :swells, :swell_venue_id, :integer
  end
end
