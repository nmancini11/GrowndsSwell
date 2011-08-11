class PlansController < ApplicationController
  before_filter :already_planned, :only => [ :join ]

# Allows a user to make another user's itinerary their own.  Through
# either an invite or even straight through the new feed without
# an invite.
def join
  @plan = current_user.plans.create(:itinerary_id => params[:itinerary_id], :child_id => current_user.id, :parent_id => params[:parent_id])
  respond_to do |format|
    if @plan.save
      format.html { redirect_to(itineraries_path, :notice => 'Plan was successfully created.') }
    else
      format.html { redirect_to(itineraries_path, :notice => 'There was an error in joining this itinerary') }
    end
  end
end

def unjoin
  plan = current_user.plans.where(:itinerary_id => params[:itinerary_id], :child_id => current_user.id, :parent_id => params[:parent_id])
  plan[0].destroy
  
  respond_to do |format|
    format.html { redirect_to(itineraries_path, :notice => 'Plan was successfully removed.') }
  end
end

private
def already_planned
  @itinerary_id = params[:itinerary_id]
  p = current_user.plans.where(:itinerary_id => @itinerary_id)
  redirect_to(users_path, :notice => 'You are already planning on doing this!') unless p.empty?
end

end