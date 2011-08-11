class RemoveContactIdFromVenues < ActiveRecord::Migration
  def self.up
    remove_column :venues, :contact_id
  end

  def self.down
    add_column :venues, :contact_id, :integer
  end
end
