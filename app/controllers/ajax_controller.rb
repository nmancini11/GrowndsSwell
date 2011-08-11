class AjaxController < ApplicationController
  before_filter :foursquare_connect, :only => [ :venues ]
  
  def users
    if params[:term]
      users = User.find(:all, :select => "name", :conditions => ['name LIKE ?', "%#{params[:term]}%"]).map(&:name)
      respond_to do |format|
        format.json { render :json => users }
      end
    end
  end
  
  def venues
    if params[:term]
      venues = @client.venues.search(:ll => '43.0481221,-76.147424399', :query => params[:term]).places
      venue_data = Array.new
      venues.each { |v| venue_data << Hash["value" => v.name + "#{": " unless v.location.address.nil?}#{(v.location.address unless v.location.address.nil?)}", "id" => v.id] }
      
      respond_to do |format|
        format.json { render :json => venue_data }
      end
    end
  end
  
  private
  def foursquare_connect
    if current_user.on_foursquare? # use user's account if they have a foursquare account
      @client = Foursquare::Base.new(current_user.authentications[0].oauth_token)
    else # else use the application's foursquare account
      @client = Foursquare::Base.new('2YE5YAW0JPZ2YJEBDMBUNFJBCLMOFFXMTYKINK53I2ERXQAF', 'DKXTLI2SAHMYPAMWZLKBQVG5YAWZYLCKW2DVY0JBEJAH4TUM')
    end
  end
end
