class ApplicationController < ActionController::Base
  protect_from_forgery
  layout :layout_by_resource

    protected

    def layout_by_resource
      if controller_name == 'registrations' && action_name == 'edit'
        'settings'
      elsif controller_name == 'registrations' && action_name == 'update'
        'settings'
      else
        'application'
      end
    end
    
  private
  def after_update_path_for(resource)
    user_path(current_user) # You can put whatever path you want here
  end
  
  
end
