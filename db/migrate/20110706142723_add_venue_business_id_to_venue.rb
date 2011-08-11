class AddVenueBusinessIdToVenue < ActiveRecord::Migration
  def self.up
    add_column :venues, :venue_business_id, :string
  end

  def self.down
    remove_column :venues, :venue_business_id
  end
end
