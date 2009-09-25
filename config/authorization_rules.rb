authorization do
  role :guest do
    has_permission_on [:players, :games], :to => :read
  end
  
  role :user do
    includes :guest
    has_permission_on :players, :to => :read
    
    has_permission_on :players, :to => [:manage, :games] do
      if_attribute :user_id => is { user.id }
    end
  end
  
  role :admin do
    includes :user
    has_permission_on [:games, :users, :locations, :events], :to => :manage
  end
end

privileges do
  privilege :manage do
    includes :new, :create, :read, :edit, :update, :delete
  end
  
  privilege :read do
    includes :index, :show
  end
  
  privilege :games do
    includes :games, :update_games
  end

end
