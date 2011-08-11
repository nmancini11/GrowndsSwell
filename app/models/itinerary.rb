class Itinerary < ActiveRecord::Base
  belongs_to :venue
  
  has_many :users, :through => :plans
  has_many :plans, :dependent => :destroy
  has_one :original, :class_name => 'Plan', :conditions => 'child_id = parent_id'
  has_many :invites
  
  #has_many :pending_plans, :class_name => "Friendship", :foreign_key => "friend_id", :dependent => :destroy
  
  # below is code to handle the news feed
  default_scope :order => 'itineraries.start_date DESC'
  
  # Return itineraries from the users being followed by the given user.
  scope :from_users_friended_by, lambda { |user| friended_by(user) }
    
  private

    # Return an SQL condition for users followed by the given user.
    # We include the user's own id as well.
    def self.friended_by(user)
      friends = user.friends.where('status = ?', true) | user.inverse_friends.where('status = ?', true)
      itinerary_ids = Array.new
      friends.each do |friend|
        itinerary_ids << friend.itineraries
      end
      where(:id => itinerary_ids.push(user.itineraries).flatten)
    end
  
end
