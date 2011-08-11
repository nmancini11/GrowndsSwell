class Swell < ActiveRecord::Base
  belongs_to :venue
  
  def active?
    end_date > Time.now
  end
end
