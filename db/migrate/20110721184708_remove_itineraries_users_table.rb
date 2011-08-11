class RemoveItinerariesUsersTable < ActiveRecord::Migration
  def self.up
    drop_table :itineraries_users
  end

  def self.down
    create_table :itineraries_users, :id => false do |t|
      t.integer :itinerary_id
      t.integer :child_user_id
      t.integer :parent_user_id
    end
  end
end
