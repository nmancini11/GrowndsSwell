class RenameFriendshipIdToFriendId < ActiveRecord::Migration
  def self.up
    change_table :friendships do |t|
      t.rename :friendship_id, :friend_id
    end
  end

  def self.down
    change_table :friendships do |t|
      t.rename :friend_id, :friendship_id
    end
  end
end
