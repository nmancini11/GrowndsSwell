class UsersController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    if params[:term]
      @users = User.find(:all, :conditions => ['name LIKE ?', "%#{params[:term]}%"])
      if @users.size == 1 && @users[0].name == params[:term]
        redirect_to(@users[0]) and return
      end
    else
      @users = User.find(:all, :conditions => [ "id NOT IN (?)", [current_user.id]] )
    end
    foursquare_connect
    respond_to do |format|
      format.html # index.html.erb
      format.js { render :js => @users }
      format.json { render :json => @users.flatten }
      format.xml  { render :xml => @users }
    end
  end
  
  def upgrade
    @client = Foursquare::Base.new(current_user.authentications[0].oauth_token)
    @fs_user = @client.users.find(current_user.authentications[0].uid)
    @user = current_user
    
    respond_to do |format|
      format.html # upgrade.html.erb
    end
  end
  
  def complete_upgrade
    @user = current_user
    
    if @user.update_attributes(params[:user])
      redirect_to(@user, :notice => 'User was successfully upgraded.')
    else
      redirect_to(upgrade_path(@user), :notice => 'There was an error in updating this user.')
    end
  end
  
  # GET /users/1
  # GET /users/1.xml
  def show    
    @user = User.find(params[:id])
    foursquare_connect

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
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