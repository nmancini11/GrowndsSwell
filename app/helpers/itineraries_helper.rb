module ItinerariesHelper
  
  def name_address
    @venue.name + @venue.location.address
  end
end
