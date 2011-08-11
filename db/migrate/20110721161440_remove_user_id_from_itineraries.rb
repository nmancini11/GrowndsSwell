class RemoveUserIdFromItineraries < ActiveRecord::Migration
  def self.up
    remove_column :itineraries, :user_id
  end

  def self.down
    add_column :itineraries, :user_id, :integer
  end
end
