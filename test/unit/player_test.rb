require 'test_helper'

class PlayerTest < ActiveSupport::TestCase

  fixtures :seasons
  fixtures :events
  fixtures :players
  fixtures :users
  fixtures :scores

  def setup
    @mark = users(:mark)
    @previous_season = seasons(:previous)
    @current_season = seasons(:actual)
    @next_season = seasons(:next)
    
    @pascal = users(:pascal)
    
    assert_equal true, @mark.valid?
    assert_equal 8, @mark.events.size
    assert_equal 4, @pascal.player.scores.size
  end

  test "all games played" do
    assert_equal 6, @mark.player.games_played.size 
  end
  
  test "games played" do
    assert_equal 2, @mark.player.games_played(@previous_season).size
    assert_equal 4, @mark.player.games_played(@current_season).size
    assert_equal 0, @mark.player.games_played(@next_season).size
  end
  
  test "wins" do
    assert_equal 3, @mark.player.wins
    assert_equal 2, @mark.player.wins(@current_season)    
  end
  
  test "defeats" do
    assert_equal 2, @mark.player.defeats
    assert_equal 1, @mark.player.defeats(@current_season)
  end
  
  test "tied games" do
    assert_equal 1, @mark.player.tied_games
    assert_equal 1, @mark.player.tied_games(@current_season)
  end
  
  test "goal against average" do
    assert_equal 4.5, @mark.player.goal_against_average(@previous_season)
    assert_equal 3.5, @mark.player.goal_against_average(@current_season)
    assert_equal 3.83, @mark.player.goal_against_average
  end
  
  test "goals against" do
    assert_equal 9, @mark.player.goals_against(@previous_season)
    assert_equal 14, @mark.player.goals_against(@current_season)
    assert_equal 23, @mark.player.goals_against
  end
  
  test "assists of a player" do
    assert_equal 2, @pascal.player.assists
    assert_equal 2, @pascal.player.assists(@previous_season)
    assert_equal 0, @pascal.player.assists(@current_season)
    assert_equal 0, @pascal.player.assists(@next_season)
  end
  
  test "goals of a player" do
    assert_equal 5, @pascal.player.goals
    assert_equal 2, @pascal.player.goals(@previous_season)
    assert_equal 3, @pascal.player.goals(@current_season)
    assert_equal 0, @pascal.player.goals(@next_season)
  end
  
  test "points per game" do
    assert_equal 1.17, @pascal.player.points_per_game
    assert_equal 2, @pascal.player.points_per_game(@previous_season)
    assert_equal 0.75, @pascal.player.points_per_game(@current_season)
    assert_equal 0, @pascal.player.points_per_game(@next_season)
  end
  
end
