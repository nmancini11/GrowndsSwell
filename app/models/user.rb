class User < ActiveRecord::Base
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :name, :gender, :image
  
  has_many :itineraries, :through => :plans, :foreign_key => "parent_id", :dependent => :destroy
  has_many :plans, :foreign_key => "child_id"
  
  has_and_belongs_to_many :pending_invites, :class_name => 'Invite', :join_table => "pending_itinerary_invites"
  
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  
  has_many :friendships, :dependent => :destroy
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id", :dependent => :destroy
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user
  
  has_many :authentications
  
  def sent_invites
    Invite.where(:sender_id => self.id)
  end
  
  def pending_invites
    Invite.where(:recipient_id => self.id)
  end
  
  def profile_pic
    if image_file_name.nil?
      "/images/foursquare/blank_boy.png"
    else
      image_file_name
    end
  end
  
  def feed
    Itinerary.from_users_friended_by(self)
  end
  
  def on_foursquare?
    not authentications.empty?
  end
  
  def on_growndswell?
    not encrypted_password.empty?
  end
  
  # if two people are friends
  def friends_with?(user)
    f = friendships.with_user(user)[0]
    i = inverse_friendships.with_user(user)[0]
    if f.nil? and i.nil?
      false
    else
      if f.nil?
        i.status
      end
      if i.nil?
        f.status
      end
    end
  end
  
  # if user x requested user y and is waiting for a response
  def requested?(user)
    f = friendships.friended_user(user)[0]
    if f.nil?
      false
    elsif f.status == false
      true
    end
  end
  
  # if user y was requested by user x and needs to respond
  def pending?(user)
    f = inverse_friendships.pending_user(user)[0]
    if f.nil?
      false
    elsif f.status == false
      true
    end
  end
  
  def pending_friendships
    friendships.where('status = ?', false) | inverse_friendships.where('status = ?', false)
  end
  
  def confirmed_friendships
    friendships.where('status = ?', true) | inverse_friendships.where('status = ?', true)
  end
  
  def all_friends
    User.find_by_sql("select * from users u JOIN friendships f where u.id =
    #{self.id} AND (f.user_id = u.id OR f.friend_id = u.id)")
  end
  
  def future_itineraries(friends)
    fi = Array.new
    for friend in friends
      for itinerary in friend.itineraries
        fi << itinerary
      end
    end
    fi
  end
end