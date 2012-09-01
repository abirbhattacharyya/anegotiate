ActionController::Routing::Routes.draw do |map|
  map.signin '/signin', :controller => 'users', :action => 'sign_in'
  
  map.login '/login', :controller => 'users', :action => 'create'
  map.logout '/logout', :controller => 'users', :action => 'destroy'
  
  map.resources :users, :collection => {:link_user_accounts => :get}
  map.resources :items
  
  # The priority is based upon order of creation: first created -> highest priority.

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "home"
  #map.direct_message '/direct_message/:screen_name', :controller => 'users', :action => 'direct_message'
  map.invite_to '/invite_to', :controller => 'users', :action => 'invite_to'
  
  map.buy_points '/buypoints', :controller => "offers", :action => "buy_points"
  map.buy_item '/:id/buy_item', :controller => "offers", :action => "buy_item"
  
  map.get_energy '/energy', :controller => "offers", :action => "get_energy"
  map.get_tools '/tools', :controller => "offers", :action => "get_tools"
  map.paypal '/offerpal', :controller => "offers", :action => "offerpal"
  map.notifications '/notifications', :controller => "offers", :action => "notification"
  map.tasks '/tasks', :controller => "offers", :action => "tasks"
#  map.offer_style '/offers/:action', :controller => "offers"
  map.done_task '/done_task/:id', :controller => "offers", :action => "done_tasks"
  map.refresh_in '/refresh_in', :controller => "offers", :action => "refresh_in"
  map.play_again_in '/play_again_in', :controller => "offers", :action => "play_again_in"
  
  map.nego_select '/:id/select_category', :controller => "offers", :action => "nego_select"
  map.nego_process '/:id/process', :controller => "offers", :action => "nego_process"
  map.negotiated '/:id/:category_id/negotiated', :controller => "offers", :action => "negotiated"
  map.be_kind '/be_kind', :controller => "home", :action => "be_kind"
  map.send_points_list '/:id/send_points_list', :controller => "home", :action => "send_points_list"
  map.style '/style', :controller => "users", :action => "style"
  map.lottery '/lottery', :controller => "offers", :action => "lottery"
  map.play_lottery '/play_lottery', :controller => "offers", :action => "play_lottery"
  map.invite '/invite', :controller => "users", :action => "invite"
  map.send_points '/error', :controller => "home", :action => "send_points"
  map.search_users '/negotiate', :controller => "users", :action => "search"
  map.connect '/callback', :controller => 'users', :action => 'callback'
  
  map.contactus '/contactus', :controller => 'home', :action => 'contactus'
  # See how all your routes lay out with "rake routes"

#  map.page '/:page', :controller => "home", :action => "show"
  
  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format' 
end
