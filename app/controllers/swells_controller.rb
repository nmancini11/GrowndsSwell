class SwellsController < ApplicationController
  before_filter :authenticate_business!
  before_filter :get_venue, :only => [ :index ]
  before_filter :get_venues, :only => [ :new, :edit, :reswell ]
  
  # GET /venues/1/swells
  # GET /venues/1/swells.xml
  def index
    @swells = @venue.swells.where(@venue.business_id == current_business.id)
    @swell = Swell.new
    # @swells = @venue.swells.all
    @other_venues = current_business.venues - current_business.venues.where(:id => params[:venue_id])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @swells }
    end
  end

  # GET /swells/1
  # GET /swells/1.xml
  def show
    @swell = current_business.swells.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @swell }
    end
  end

  # GET /swells/new
  # GET /swells/new.xml
  def new
    if params[:venue_id].nil?
      @swell = Swell.new
    else
      get_venues
      if @venues.size < 1
        redirect_to(venues_path, :notice => 'You must create a Venue before you can create swells.')
      end
      get_venue
      @swell = @venue.swells.build
      @venue_id = params[:venue_id]
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @swell }
    end
  end
  
  # GET /swells/1/reswell
  # GET /swells/1/reswell.xml
  def reswell
    if params[:venue_id].nil?
      @swell = Swell.new
    else
      get_venues
      if @venues.size < 1
        redirect_to(venues_path, :notice => 'You must create a Venue before you can create swells.')
      end
      get_venue
      @swell = @venue.swells.build
      @venue_id = params[:venue_id]
    end
    @orig_swell = Swell.find(params[:swell_id])

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @swell }
    end
  end

  # GET /swells/1/edit
  def edit
    @swell = current_business.swells.find(params[:id])
  end

  # POST /swells
  # POST /swells.xml
  def create
    @swell = Swell.create(params[:swell])

    respond_to do |format|
      if @swell.save
        format.html { redirect_to(@swell, :notice => 'Swell was successfully created.') }
        format.xml  { render :xml => @swell, :status => :created, :location => @swell }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @swell.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /swells/1
  # PUT /swells/1.xml
  def update
    @swell = Swell.find(params[:id])

    respond_to do |format|
      if @swell.update_attributes(params[:swell])
        format.html { redirect_to(@swell, :notice => 'Swell was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @swell.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /swells/1
  # DELETE /swells/1.xml
  def destroy
    @swell = Swell.find(params[:id])
    @swell.destroy

    respond_to do |format|
      format.html { redirect_to(swells_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  def get_venue
    @venue = current_business.venues.find(params[:venue_id])
  end
  
  private
  def get_venues
    @venues = current_business.venues.all
  end
end
