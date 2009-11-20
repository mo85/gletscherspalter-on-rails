authorization do
  role :guest do
    has_permission_on [:players, :games, :news, :photos], :to => :read
    has_permission_on :root, :to => [:index, :contact, :locations]
  end
  
  role :user do
    includes :guest
    has_permission_on :players, :to => [:adjust, :subscribe_to_games] do
      if_attribute :user => is { user }
    end
    
    has_permission_on :topics, :to => [:read]
    has_permission_on :topics, :to => :manage do 
      if_attribute :owner => is { user }
    end
    
    has_permission_on :posts, :to => [:read, :create_posts]
    has_permission_on :posts, :to => :update_posts do
      if_attribute :user => is { user }
    end
    
  end
  
  role :admin do
    includes :user
    has_permission_on [:players, :users, :scores, :topics, :news], :to => [:read, :manage]
    has_permission_on :players, :to => :subscribe_to_games
    has_permission_on [:locations, :events, :messages], :to => [:read, :manage]
    has_permission_on :games, :to => [:read, :manage, :add_or_remove_players_from_games]
    has_permission_on :posts, :to => :update_posts
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
  
  privilege :subscribe_to_games do
    includes :games, :update_games
  end
  
  privilege :adjust_scores do
    includes :edit_scores, :update_scores
  end
  
  privilege :add_or_remove_players_from_games do
    includes :add_player, :save_added_player, :remove_player
  end
  
  privilege :create_posts do
    includes :new, :create
  end
  
  privilege :update_posts do
    includes :edit, :update, :destroy
  end

end
