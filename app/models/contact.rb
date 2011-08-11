class Contact < ActiveRecord::Base
  belongs_to :venue
  
  validates :name, :presence => true
  validates :email_address, :presence => true
  validates :phone_number, :presence => true
end
