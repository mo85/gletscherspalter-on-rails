module GamesHelper
  
  def summary_sentence(all_players)
    goalies = all_players.select{ |p| p.position == "G" }.size
    result_string = "Total: #{all_players.size - goalies} Spieler und "
    if goalies == 0
      result_string << "<strong>kein</strong>"
    else
      result_string << "#{goalies}"
    end
    result_string << " Goalie"
    result_string
  end
end
