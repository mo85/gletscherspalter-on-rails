authorization do
  role :guest do
    has_permission_on [:players, :games], :to => :read
  end
  
  role :user do
    includes :guest
    has_permission_on :players, :to => [:adjust, :subscribe_to_games] do
      if_attribute :user => is { user }
    end
  end
  
  role :admin do
    includes :user
    has_permission_on [:players, :games, :users, :scores], :to => [:read, :manage]
    has_permission_on :players, :to => :subscribe_to_games
    has_permission_on [:locations, :events, :messages], :to => [:read, :manage]
  end
end

privileges do
  privilege :manage do
    includes :new, :create, :adjust, :delete, :destroy
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

end
