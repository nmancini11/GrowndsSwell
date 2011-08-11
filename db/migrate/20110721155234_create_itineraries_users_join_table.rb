class CreateItinerariesUsersJoinTable < ActiveRecord::Migration
  def self.up
    create_table :itineraries_users, :id => false do |t|
      t.integer :itinerary_id
      t.integer :child_user_id
      t.integer :parent_user_id
    end
  end

  def self.down
    drop_table :itineraries_users
  end
end
