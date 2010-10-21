GletscherspalterOnRails::Application.routes.draw do
  
  resources :photos, :except => [:edit, :new, :create, :update, :destroy]
  
  resources :news
  
  resources :guestnotes, :except => [:show]
  
  resources :messages, :except => [:show, :edit, :update]

  resources :events do 
    member do
      delete  "remove_player"
      get     "add_player"
      post    "save_added_player"
      post    "add_comment"
    end
  end
    
  resources :comments, :only => [:edit, :update, :destroy]

  resources :locations, :except => [:show]

  resources :rinks, :except => [:show]
  
  resources :seasons do 
    member do
       get "statistics"
    end
  end

  resources :topics do 
    resources :posts, :except => [:show, :index]
  end

  resources :users, :except => :show, :member => { 
      :edit_subscriptions => :get, 
      :update_subscriptions => :put
    } do 
    resources :user_pictures, :only => [:new, :create]
  end

  resources :trainings, :except => :index
  resources :trainingscamps, :except => :index

  resources :games do
    resources :scores, :except => [:show, :index]
  end
  
  #match "users/:user_id/resource/:id/toggle_setting", "resource_settings#toggle_resource_setting", :as => "toggle_resource_setting"
  
  #location_on_map "root/locations/:id", :controller => "root", :action => "locations"

  root :to => "root#index"
  
  match "denied"        => "root#denied"
  match "history"       => "root#history"
  match "contacts"      => "root#contact"
  match "login"         => "admin#login"

  #facebook "root/fb_news", :controller => "root", :action => "fb_news"
  
  resources :players do
    member do 
      get "events"
      post "update_events"
    end
  end


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
  match ':controller(/:action(/:id(.:format)))'
end
