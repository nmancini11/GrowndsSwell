class FriendshipsController < ApplicationController
  before_filter :already_friends, :only => [ :create ]
  before_filter :get_friendship, :only => [ :destroy ]

# creates a friendship entry in the friendships table.  checks to see that
# the friendship doesn't already exist.  sets the status of the friendship
# to false.
#
# params
# friend_id: friend that will receive a request 
def create
  @friendship = current_user.friendships.create(:friend_id => @friend_id)
  @friendship.status = false
  if @friendship.save
    flash[:notice] = "Added friend."
    redirect_to users_path
  else
    flash[:error] = "Unable to add friend."
    redirect_to users_path
  end
end

# destroys a friendship entry in the friendships table.  checks to see that
# the friendship exists before calling destroy.  this method is called when
# denying a friendship and also when destroying a mutual friendship
# 
# params
# id: id of the friendship that gets deleted
def destroy
  get_friendship
  @friendship.destroy
  flash[:notice] = "Removed friendship."
  redirect_to current_user
end

# confirms that the user wants to be friends with the requester.  all that
# changes is the status is set to true.
#
# params
# id: id of the friendship that is being accepted
def accept
  @friendship = current_user.inverse_friendships.find(params[:id])
  @friendship.status = true
  @friendship.save
  redirect_to current_user
end

# checks whether two people currently have a relationship -- either mutual or
# pending.  if true, redirect to users_path with a notice
#
# params
# friend_id: id of the friend that a relationship is being checked for
private
def already_friends
  @friend_id = params[:friend_id]
  f = current_user.friendships.with_user(@friend_id)[0]
  i = current_user.inverse_friendships.with_user(@friend_id)[0]
  redirect_to(users_path, :notice => 'This friendship already exists') unless ( f.nil? and i.nil? )
end

private
def get_friendship
  if current_user.inverse_friendships.exists?(params[:id])
    @friendship = current_user.inverse_friendships.find(params[:id])
  elsif current_user.friendships.exists?(params[:id])
    @friendship = current_user.friendships.find(params[:id])
  else
    redirect_to(users_path, :notice => 'This friendship does not exist')
  end
end

end