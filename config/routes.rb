ActionController::Routing::Routes.draw do |map|
  #map.resources :roles

  map.resources :photos, :except => [:edit, :new, :create, :update, :destroy]
  
  map.resources :news
  
  map.resources :guestnotes, :except => [:show]
  
  map.resources :messages, :except => [:show, :edit, :update]

  map.resources :events, :member => { 
    :remove_player => :delete,
    :add_player => :get,
    :save_added_player => :post 
    }

  map.resources :locations, :except => [:show]

  map.resources :rinks, :except => [:show]
  
  map.resources :seasons, :only => [:index],
    :member => { :statistics => :get }

  map.resources :topics do |topics|
    topics.resources :posts, :except => [:show, :index]
  end

  map.resources :users, :except => :show do |users|
    users.resources :user_pictures, :only => [:new, :create]
  end

  map.resources :trainings, :except => :index
  map.resources :trainingscamps, :except => :index

  map.resources :games, :member => { :add_comment => :post } do |games|
    games.resources :scores, :except => [:show, :index]
  end
  
  map.location_on_map "root/locations/:id", :controller => "root", :action => "locations"
  map.contacts "root/contact", :controller => "root", :action => "contact"
  map.home "root/index", :controller => "root", :action => "index"
  map.denied "root/denied", :controller => "root", :action => "denied"
  map.history "root/history", :controller => "root", :action => "history"

  map.login "admin/login", :controller => "admin", :action => "login"

  map.facebook "root/fb_news", :controller => "root", :action => "fb_news"
  
  map.resources :players, :member => { :events => :get, :update_events => :post } #, :collection => { :team => :get }

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
   map.root :controller => "root", :action => "index"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
