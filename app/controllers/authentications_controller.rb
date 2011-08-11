class AuthenticationsController < ApplicationController
  def index
    @authentications = current_user.authentications if current_user
  end

  def create
    omniauth = request.env["omniauth.auth"]
    # search for an existing authentication; whether the user has signed in with foursquar before or not
    authentication = Authentication.find_by_uid(omniauth['uid'])
    # use growndswell's client codes to generate a foursquare object
    foursquare = Foursquare::Base.new("2YE5YAW0JPZ2YJEBDMBUNFJBCLMOFFXMTYKINK53I2ERXQAF", "DKXTLI2SAHMYPAMWZLKBQVG5YAWZYLCKW2DVY0JBEJAH4TUM")
    # generate the access_token for this user to be able to do queries using the above foursquare object
    @access_token = foursquare.access_token(params['code'], "http://localhost:3000/auth/foursquare/callback")
    if authentication # user has signed into growndswell with their foursquare before
      authentication.oauth_token = @access_token
      authentication.save!
      flash[:notice] = "Signed in successfully"
      sign_in_and_redirect(:user, authentication.user)
    elsif current_user # user has not signed into growndswell with foursquare but has a growndswell account that is signed in
      current_user.authentications.create!(:uid => omniauth['uid'], :oauth_token => @access_token)
      redirect_to itineraries_path, :notice => "Authentication successful"
    else # user has not signed into growndswell with their foursquare before and is not signed into a growndswell account
      user = User.new
      foursquare_connect
      fs_user = @client.users.find(omniauth['uid'])
      user.name = fs_user.name
      user.authentications.build(:uid => omniauth['uid'], :oauth_token => @access_token)
      if user.save(:validate => false)
        sign_in_and_redirect(:user, user)
      end
    end
  end

  def destroy
    @authentication = Authentication.find(params[:id])
    @authentication.destroy
    redirect_to user_path(current_user), :notice => "Successfully destroyed authentication."
  end
  
  private
  def foursquare_connect
    @client = Foursquare::Base.new(@access_token)
  end
end
