authorization do
  role :guest do
    has_permission_on [:players, :games, :news, :photos, :events, :trainings, :trainingscamps], :to => :read
    has_permission_on :root, :to => [:index, :contact, :locations, :fb_news, :denied, :history]
    has_permission_on :seasons, :to => [:index, :statistics, :season_not_found]
    has_permission_on :guestnotes, :to => [:index, :new, :create]
    has_permission_on :sponsors, :to => [ :read, :new, :create]
  end
  
  role :sponsor do
    includes :guest
  end
  
  role :user do
    includes :guest
    has_permission_on :players, :to => [:adjust, :subscribe_to_events] do
      if_attribute :user => is { user }
    end
    
    has_permission_on :events, :to => [:add_comment]
    
    has_permission_on :topics, :to => [:read]
    has_permission_on :topics, :to => :manage do 
      if_attribute :owner => is { user }
    end
    
    has_permission_on :posts, :to => [:read, :create_posts]
    has_permission_on :posts, :to => :update_posts do
      if_attribute :user => is { user }
    end

    has_permission_on :users, :to => [:read, :edit_subscriptions, :update_subscriptions]
    has_permission_on :avatars, :to => [:new, :create] do
      if_attribute :user => is { user }
    end
    
    has_permission_on :resource_settigs, :to => :toggle_ressource_setting
    
  end
  
  role :chair_member do
    includes :user
    has_permission_on :messages, :to => [:read, :manage]
  end
  
  role :admin do
    includes :user
    has_permission_on [:players, :users, :scores, :topics, :news, :guestnotes, :photos, :games, :sponsors], :to => [:read, :manage]
    has_permission_on :players, :to => [:subscribe_to_events, :team]
    has_permission_on [:locations, :events, :messages, :trainings, :trainingscamps, :comments], :to => [:read, :manage]
    has_permission_on :events, :to => [:read, :manage, :add_or_remove_players_from_events]
    has_permission_on :posts, :to => :update_posts

    has_permission_on :user_pics, :to => [:new, :create]
  end
end

privileges do
  privilege :manage do
    includes :new, :create, :adjust, :destroy
  end
  
  privilege :read do
    includes :index, :show
  end
  
  privilege :adjust do
    includes :edit, :update
  end
  
  privilege :subscribe_to_events do
    includes :events, :update_events
  end
  
  privilege :adjust_scores do
    includes :edit_scores, :update_scores
  end
  
  privilege :add_or_remove_players_from_events do
    includes :add_player, :save_added_player, :remove_player
  end
  
  privilege :create_posts do
    includes :new, :create
  end
  
  privilege :update_posts do
    includes :edit, :update, :destroy
  end

end
