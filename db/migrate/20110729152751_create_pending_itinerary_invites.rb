class CreatePendingItineraryInvites < ActiveRecord::Migration
  def self.up
    create_table :pending_itinerary_invites, :id => :false do |t|
      t.integer :user_id
      t.integer :itinerary_invite_id

      t.timestamps
    end
  end

  def self.down
    drop_table :pending_itinerary_invites
  end
end
