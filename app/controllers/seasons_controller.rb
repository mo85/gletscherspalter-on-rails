class SeasonsController < ApplicationController
  
  filter_access_to :all
  
  def index
    @seasons = Season.all :order => "created_at DESC"
    
    respond_to do |format|
      format.html
    end
  end
  
  def statistics
    #unless read_fragment(:action => "statistics", :id => params[:id])
      @season = Season.where("start_year = ? AND end_year = ?", params[:start], params[:end]).first

      @game_stats = [@season.wins.size, @season.defeats.size, @season.tied_games.size]

      player_goal_assist_entries = Player.all.collect { |p|
        if p.goals(@season) > 0 || p.assists(@season) > 0
          [p.name, p.goals(@season), p.assists(@season)]
        end
      }.compact
      @scorer_names = player_goal_assist_entries.collect{|e| e[0]}
      goals = player_goal_assist_entries.collect{|e| e[1]}
      assists = player_goal_assist_entries.collect{|e| e[2]}
      @score_stats = [goals, assists]
      @max_value = [goals,assists].flatten.max

      @goals = @season.scored_goals
      @goals_against = @season.goals_against
  
      @players = Player.players_with_scores(@season).sort{|p1, p2| p1.points_per_game(@season) <=> p2.points_per_game(@season)}.reverse
      @goalies = Player.goalies.select{|p| p.games_played(@season).size > 0}

    #end
  end
  
end