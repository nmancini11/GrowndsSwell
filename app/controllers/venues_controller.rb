class VenuesController < ApplicationController
  before_filter :authenticate_business!, :except => [ :show_to_user ]
  before_filter :active_venue_check, :only => [ :show, :edit ]
  #before_filter :valid_address_check, :only => [ :create, :update ]
  #before_filter :accurate_address_check, :only => [ :create, :update ]
  before_filter :get_address, :only => [ :create, :update ]
  before_filter :one_venue_redirect, :only => [ :index ]
  layout 'application', :except => [ :show_to_user ]
  before_filter :foursquare_connect, :only => [ :show_to_user ]
  
  
  # GET /venues
  # GET /venues.xml
  def index    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @venues }
    end
  end
  
  # GET /venues/1/show_to_user
  def show_to_user
    @users = Array.new
    @venue = Venue.find(params[:venue_id])
    if @venue.on_foursquare?
      @foursquare_venue = @client.venues.find(@venue.fsvid)
      @venue.street_address_1 = @foursquare_venue.location.address
      @venue.city = @foursquare_venue.location.city
      @venue.state = @foursquare_venue.location.state
      @venue.name = @foursquare_venue.name
    end
    @itineraries = Itinerary.find(:all, :conditions => ["venue_id = ? AND start_date BETWEEN ? AND ?", 
      @venue.id, Time.now.beginning_of_day-1.week, Time.now])
    @itineraries.each do |itinerary|
      p = Plan.where(:itinerary_id => itinerary.id)
      @users << p
    end
    @users.flatten!
      
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /venues/1
  # GET /venues/1.xml
  def show    
    @venue = current_business.venues.find(params[:id])
    @contact = @venue.contact
    @hours = @venue.hours

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @venue }
    end
  end

  # GET /venues/new
  # GET /venues/new.xml
  def new
    @venue = current_business.venues.build
    @venue.build_contact   # create a contact from the venue form
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @venue }
    end
  end

  # GET /venues/1/edit
  def edit
    @venue = current_business.venues.find(params[:id])
    
    @day_iterator = 0
  end

  # POST /venues
  # POST /venues.xml
  def create
    
    if @response['status'] == "OK"
      latitude = @response['results'][0]['geometry']['location']['lat']
      longitude = @response['results'][0]['geometry']['location']['lng']

      params[:venue]['latitude'] = latitude
      params[:venue]['longitude'] = longitude
    end
    
    # @venue = Venue.new(params[:venue])
    @venue = current_business.venues.create(params[:venue])

    respond_to do |format|
      if @venue.save
        format.html { redirect_to(@venue, :notice => 'Venue was successfully created.') }
        format.xml  { render :xml => @venue, :status => :created, :location => @venue }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @venue.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /venues/1
  # PUT /venues/1.xml
  def update
    latitude = @response['results'][0]['geometry']['location']['lat']
    longitude = @response['results'][0]['geometry']['location']['lng']
    params[:venue]['latitude'] = latitude
    params[:venue]['longitude'] = longitude
    
    params[:venue][:venue_type_ids] ||= []
    @venue = current_business.venues.find(params[:id])

    respond_to do |format|
      if @venue.update_attributes(params[:venue])
        format.html { redirect_to(@venue, :notice => 'Venue was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @venue.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /venues/1
  # DELETE /venues/1.xml
  def destroy
    @venue = Venue.find(params[:id])
    #@venue.destroy
    @venue.active = false
    @venue.save

    respond_to do |format|
      format.html { redirect_to(venues_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  def active_venue_check
    @venue = current_business.venues.find(params[:id])
    if @venue.active == false
      redirect_to(venues_path, :notice => 'This venue is no longer active')
    end
  end
  
  private
  def valid_address_check
    require 'net/http'
    street_address_1 = params[:venue]['street_address_1'].gsub(' ', '+')
    street_address_2 = params[:venue]['street_address_2'].gsub(' ', '+')
    city = params[:venue]['city'].gsub(' ', '+')
    state = params[:venue]['state'].gsub(' ', '+')
    unformatted_response = Net::HTTP.get_response("maps.googleapis.com", "/maps/api/geocode/json?address=#{street_address_1},+#{city},+#{state}&sensor=false")
    @response = ActiveSupport::JSON.decode(unformatted_response.body)
    @status = @response['status']
    
    redirect_to(new_venue_path, :notice => 'Valid address not provided') if @response['status'] != "OK"
  end
  
  private
  def get_address
    require 'net/http'
    street_address_1 = params[:venue]['street_address_1'].gsub(' ', '+')
    street_address_2 = params[:venue]['street_address_2'].gsub(' ', '+')
    city = params[:venue]['city'].gsub(' ', '+')
    state = params[:venue]['state'].gsub(' ', '+')
    unformatted_response = Net::HTTP.get_response("maps.googleapis.com", "/maps/api/geocode/json?address=#{street_address_1},+#{city},+#{state}&sensor=false")
    @response = ActiveSupport::JSON.decode(unformatted_response.body) #decode the JSON and turn it into an array. Causes 500 Internal Server Error if
                                                                      #JSON data wasn't returned in line above.
    @status = @response['status']
  end
  
  private
  def accurate_address_check
    redirect_to(new_venue_path, :notice => 'Address is not accurate enough') if @response['results'][0]['types'][0] != "street_address"
  end
  
  private
  def one_venue_redirect
    @inactive_venues = current_business.venues.where(:active => false)
    @venues = current_business.venues.all - @inactive_venues
    redirect_to(venue_swells_path(@venues[0])) if @venues.size == 1
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