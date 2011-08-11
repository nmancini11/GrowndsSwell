class AddVenueIdToSwells < ActiveRecord::Migration
  def self.up
    add_column :swells, :venue_id, :integer
  end

  def self.down
    remove_column :swells, :venue_id
  end
end
