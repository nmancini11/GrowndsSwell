class AddVenueIdToContacts < ActiveRecord::Migration
  def self.up
    add_column :contacts, :venue_id, :integer
  end

  def self.down
    remove_column :contacts, :venue_id
  end
end
