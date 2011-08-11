class Invite < ActiveRecord::Base
  belongs_to :itinerary
  has_and_belongs_to_many :invitees, :class_name => 'User', :join_table => "pending_itinerary_invites", :foreign_key => 'invite_id'
  
end
