class Venue < ActiveRecord::Base
  has_and_belongs_to_many :venue_types
  has_many :swells
  has_one :contact
  accepts_nested_attributes_for :contact
  belongs_to :business
  has_many :itineraries
  has_many :hours
  accepts_nested_attributes_for :hours
  
  def on_foursquare?
    not fsvid.nil?
  end
  
  validate :address_must_be_valid
    
  def address_must_be_valid
    if latitude.nil? || longitude.nil?
      errors.add(:base, "A valid address was not provided.")
    end
  end
end
