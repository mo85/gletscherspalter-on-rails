module UsersHelper
  
  def active_players_count
    "(#{User.number_of_active_players} aktive Spieler)"
  end
  
  def active_player(user)
    if user.is_player
      result = "Ja"
    else
      result = "Nein"
    end
    result
  end
  
  def icon_for_property(subscription_manager, property, elem)
    html = ""
    if (subscription_manager.send(property))
      html = link_to_function image_tag("icons/tick.png"), 
        "Glacier.Utilities.Subscriptions.toggleSubscription('#{elem}', '#{update_subscriptions_user_path(subscription_manager.user)}', '#{property}');"
    else
      html = link_to_function image_tag("icons/cross.png"), 
        "Glacier.Utilities.Subscriptions.toggleSubscription('#{elem}', '#{update_subscriptions_user_path(subscription_manager.user)}', '#{property}');"
    end
    html
  end

end
