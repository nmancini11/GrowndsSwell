class Friendship < ActiveRecord::Base
  
belongs_to :user
belongs_to :friend, :class_name => "User"

# determines if 2 people share a friendship
scope :with_user, lambda { |user_id| where("friend_id = ? or user_id = ?", user_id, user_id) }

scope :friended_user, lambda { |user_id| where("friend_id = ?", user_id) }

scope :pending_user, lambda { |user_id| where("user_id = ?", user_id) }

end
