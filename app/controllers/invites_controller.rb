class InvitesController < ApplicationController
  before_filter :get_itinerary, :only => [ :new, :edit, :update, :index ]
  layout 'application', :except => [ :new, :create, :success ]
  before_filter :foursquare_connect, :only => [ :new ]
  
  # GET /invites
  # GET /invites.xml
  def index
    @invites = @itinerary.invites

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @invites }
    end
  end

  # GET /invites/1
  # GET /invites/1.xml
  def show
    @invite = @itinerary.invites.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @invite }
    end
  end

  # GET /invites/new
  # GET /invites/new.xml
  def new
    @invite = @itinerary.invites.build
    @friends = current_user.friends | current_user.inverse_friends
    @venue = Venue.find(@itinerary.venue_id)
    
    if @venue.on_foursquare?
      @venue.name = @client.venues.find(Venue.find(@itinerary.venue_id).fsvid).name
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @invite }
    end
  end

  # GET /invites/1/edit
  def edit
    @invite = Invite.find(params[:id])
    @friends = current_user.friends | current_user.inverse_friends
    
  end
  
  def accept
    @invite = Invite.find(params[:id])
    
    @plan = current_user.plans.create(:itinerary_id => @invite.itinerary_id, :child_id => current_user.id, :parent_id => @invite.sender_id)
    @invite.destroy
    respond_to do |format|
      if @plan.save
        format.html { redirect_to(itineraries_path, :notice => 'Plan was successfully created.') }
      else
        format.html { redirect_to(itineraries_path, :notice => 'There was an error in joining this itinerary') }
      end
    end
    
  end
  
  def decline
    @invite = Invite.find(params[:id])
    @invite.destroy
    redirect_to(itineraries_path, :notice => 'Event was successfully declined.')
  end

  # POST /invites
  # POST /invites.xml
  def create
    friend_ids = params[:invite]['friend_ids']
    params[:invite].delete("friend_ids")
    
    friend_ids.each do |friend_id|
      @invite = Invite.new(params[:invite])
      @invite.recipient_id = friend_id
      @invite.save!
    end
    
    #redirect_to(itinerary_invites_path(params[:invite][:itinerary_id]), :notice => 'Invite was successfully created.')
    redirect_to(itinerary_invite_success_path(params[:invite][:itinerary_id]), :notice => 'Invites were successfully sent.')
  end

  # PUT /invites/1
  # PUT /invites/1.xml
  def update
    @invite = Invite.find(params[:id])

    respond_to do |format|
      if @invite.update_attributes(params[:invite])
        format.html { redirect_to(@invite, :notice => 'Invite was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @invite.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /invites/1
  # DELETE /invites/1.xml
  def destroy
    @invite = Invite.find(params[:id])
    @invite.destroy

    respond_to do |format|
      format.html { redirect_to(invites_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  def get_itinerary
    @itinerary = current_user.itineraries.find(params[:itinerary_id])
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
