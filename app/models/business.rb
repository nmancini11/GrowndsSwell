class Business < ActiveRecord::Base
  has_many :venues
  has_many :swells, :through => :venues
  has_many :contacts, :through => :venues
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name,  :presence => true,
                    :uniqueness => true
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
    :username, :name
end
