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

end
