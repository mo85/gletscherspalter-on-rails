authorization do
  role :guest do
    has_permission_on [:players, :games], :to => :read
  end
  
  role :user do
    has_permission_on [:players, :games,], :to => :read
    has_permission_on [:games], :to => :subscribe
  end
  
  role :admin do
    has_permission_on [:players, :games, :users, :locations, :events], :to => :manage
    has_permission_on [:games], :to => :subscribe
  end
end

privileges do
  privilege :manage do
    includes :new, :create, :read, :update, :delete
  end
  
  privilege :read do
    includes :index, :show
  end
  
  privilege :subscribe do
    includes :subscribable, :update_subscribable
  end

end
