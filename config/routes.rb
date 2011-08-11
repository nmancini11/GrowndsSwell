Backend::Application.routes.draw do

  resources :authentications

  devise_for :users
  
  devise_for :businesses
  
  resources :itineraries do
    match 'join/:parent_id' => 'plans#join', :as => 'join'
    match 'unjoin/:parent_id' => 'plans#unjoin', :as => 'unjoin'
    resources :invites, :except => [ :update ]
    match 'success' => 'itineraries#success', :as => 'invite_success', :via => :get
    match 'attending' => 'itineraries#attending', :as => 'attending'
  end

  resources :invites, :except => [ :index, :update ]

  resources :users do
    match 'upgrade' => 'users#upgrade', :as => 'upgrade'
    #get :autocomplete_user_name, :on => :collection
  end

  match 'ajax/users' => 'ajax#users', :as => 'ajax_users'
  match 'ajax/venues' => 'ajax#venues', :as => 'ajax_venues'
  
  resources :check_ins

  resources :venue_types
  resources :swells, :except => [ :index ]
  resources :contacts, :except => [ :index ]

  resources :venues do
    resources :swells, :except => [ :show ]
    resources :contacts
    match 'show_to_user' => 'venues#show_to_user', :as => 'show_to_user'
  end
  
  resources :swells do
    match 'reswell' => 'swells#reswell', :as => 'reswell'
  end
  
  root :to => 'itineraries#index'
  
  match 'friendships/friend' => 'friendships#create', :as => 'friend'
  match 'friendships/unfriend' => 'friendships#destroy', :as => 'unfriend'
  match 'friendships/accept' => 'friendships#accept', :as => 'accept'
  
  match 'invites/:id/accept' => 'invites#accept', :as => 'accept_invite'
  match 'invites/:id/decline' => 'invites#decline', :as => 'decline_invite'
  
  
  match 'auth/foursquare/callback' => 'authentications#create'
  
  match 'user/upgrade' => 'users#complete_upgrade', :as => 'upgrade'
    
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
