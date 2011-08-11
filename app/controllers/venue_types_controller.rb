class VenueTypesController < ApplicationController
  before_filter :authenticate_business!
  
  # GET /venue_types
  # GET /venue_types.xml
  def index
    @venue_types = VenueType.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @venue_types }
    end
  end

  # GET /venue_types/1
  # GET /venue_types/1.xml
  def show
    @venue_type = VenueType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @venue_type }
    end
  end

  # GET /venue_types/new
  # GET /venue_types/new.xml
  def new
    @venue_type = VenueType.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @venue_type }
    end
  end

  # GET /venue_types/1/edit
  def edit
    @venue_type = VenueType.find(params[:id])
  end

  # POST /venue_types
  # POST /venue_types.xml
  def create
    @venue_type = VenueType.new(params[:venue_type])

    respond_to do |format|
      if @venue_type.save
        format.html { redirect_to(@venue_type, :notice => 'Venue type was successfully created.') }
        format.xml  { render :xml => @venue_type, :status => :created, :location => @venue_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @venue_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /venue_types/1
  # PUT /venue_types/1.xml
  def update
    @venue_type = VenueType.find(params[:id])

    respond_to do |format|
      if @venue_type.update_attributes(params[:venue_type])
        format.html { redirect_to(@venue_type, :notice => 'Venue type was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @venue_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /venue_types/1
  # DELETE /venue_types/1.xml
  def destroy
    @venue_type = VenueType.find(params[:id])
    @venue_type.destroy

    respond_to do |format|
      format.html { redirect_to(venue_types_url) }
      format.xml  { head :ok }
    end
  end
end
