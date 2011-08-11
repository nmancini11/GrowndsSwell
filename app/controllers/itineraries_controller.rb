class ItinerariesController < ApplicationController
  before_filter :authenticate_user!
  layout 'application', :except => [ :success, :new, :create, :attending ]
  autocomplete :user, :name
  
  # GET /itineraries
  # GET /itineraries.xml
  def index
    @itineraries = current_user.itineraries
    @friendships = current_user.confirmed_friendships
    @feed_items = current_user.feed
    @feed_items.sort! { |a,b| b.start_date <=> a.start_date }
    @todays_plans = current_user.itineraries.find(:all, 
          :conditions => ["start_date BETWEEN ? AND ?", Time.now.beginning_of_day, 1.day.from_now.beginning_of_day+4.hours])
    
    if current_user.on_foursquare?
      @client = Foursquare::Base.new(current_user.authentications[0].oauth_token)
    else
      @client = Foursquare::Base.new('2YE5YAW0JPZ2YJEBDMBUNFJBCLMOFFXMTYKINK53I2ERXQAF', 'DKXTLI2SAHMYPAMWZLKBQVG5YAWZYLCKW2DVY0JBEJAH4TUM')
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @itineraries }
    end
  end
  
  # GET /itineraries/1/success
  def success
    respond_to do |format|
      format.html
    end
  end

  # GET /itineraries/1
  # GET /itineraries/1.xml
  def show
    @itinerary = current_user.itineraries.find(params[:id])
    
    foursquare_connect

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @itinerary }
    end
  end

  # GET /itineraries/new
  # GET /itineraries/new.xml
  def new
    @itinerary = current_user.itineraries.build
    # search term provided from the "multipart" form
    @search_term_provided = params[:search_term]
    foursquare_connect
    
    unless @search_term_provided.nil? # skip this if there is no search term      
      # hardcoded search for Syracuse University
      response = @client.venues.search(:ll => '43.0481221,-76.147424399', :query => @search_term_provided)
      # get all of the places returned from the search
      @venues = response.places
    end
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @itinerary }
    end
  end

  # GET /itineraries/1/edit
  def edit
    @itinerary = current_user.itineraries.find(params[:id])
    @venues = Venue.all
  end

  # POST /itineraries
  # POST /itineraries.xml
  def create
    # get the foursquare venue id
    fsvid = params[:itinerary][:venue_id]

    foursquare_connect
    
    # get the venue's information from foursquare
    response = @client.venues.find(fsvid)
    
    # prep the data for being sent to google
    street_address = response.location.address.gsub(' ', '+')
    city = response.location.city.gsub(' ', '+')
    state = response.location.state.gsub(' ', '+')
    
    # get a response from google
    unformatted_response = Net::HTTP.get_response("maps.googleapis.com", "/maps/api/geocode/json?address=#{street_address},+#{city},+#{state}&sensor=false")
    # convert the response to JSON
    info = ActiveSupport::JSON.decode(unformatted_response.body)
    
    if info['status'] == "OK" # pull data only if the data is there to be pulled
      latitude = info.results[0].geometry.location.lat
      longitude = info.results[0].geometry.location.lng
    end
    
    # try to find if this venue exists
    venue = Venue.where(:fsvid => fsvid)
    unless venue.exists? # skip if venue already exists
      # create a new venue with many null values
      newvenue = Venue.create(:fsvid => fsvid, :latitude => latitude, :longitude => longitude)
      if newvenue.save # successfully saved
        venue = Venue.where(:fsvid => fsvid)
      else # there was an error
        respond_to do |format|
          format.html { render :action => "new" }
        end
      end
    end
    
    # set the itinerarie's venue_id to either the venue that was found with the appropriate
    # foursquare venue_id or the newly created one -- overwrite the fsvid value
    
    params[:itinerary][:venue_id] = venue[0].id    
    params[:itinerary][:start_date] = DateTime.strptime(params[:itinerary][:start_date], "%Y-%m-%d %H:%M:%S")
    
    # finally create the itinerary
    @itinerary = current_user.itineraries.create(params[:itinerary])

    respond_to do |format|
      if @itinerary.save
        @itinerary.plans[0].update_attribute(:parent_id, current_user.id)
        format.html { redirect_to(new_itinerary_invite_path(@itinerary), :notice => 'Itinerary was successfully created.') }
        format.xml  { render :xml => new_itinerary_invite_path(@itinerary), :status => :created, :location => @itinerary }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @itinerary.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /itineraries/1
  # PUT /itineraries/1.xml
  def update
    @itinerary = Itinerary.find(params[:id])

    respond_to do |format|
      if @itinerary.update_attributes(params[:itinerary])
        format.html { redirect_to(@itinerary, :notice => 'Itinerary was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @itinerary.errors, :status => :unprocessable_entity }
      end
    end
  end

  def attending
    @plans_made = Plan.where(:itinerary_id => params[:itinerary_id])
    
    respond_to do |format|
      format.html
    end
  end

  # DELETE /itineraries/1
  # DELETE /itineraries/1.xml
  def destroy
    @itinerary = Itinerary.find(params[:id])
    @itinerary.destroy

    respond_to do |format|
      format.html { redirect_to(itineraries_url) }
      format.xml  { head :ok }
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
