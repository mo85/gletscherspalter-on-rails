require 'test_helper'

class PlayerTest < ActiveSupport::TestCase

  fixtures :seasons
  fixtures :games
  fixtures :players
  fixtures :scores

  def setup
    @mark = players(:mark)
    @previous_season = seasons(:previous)
    @current_season = seasons(:actual)
    @next_season = seasons(:next)
    
    @pascal = players(:pascal)
    
    assert_equal true, @mark.valid?
    assert_equal 8, @mark.games.size
    assert_equal 4, @pascal.scores.size
  end

  test "all games played" do
    assert_equal 6, @mark.games_played.size 
  end
  
  test "games played" do
    assert_equal 2, @mark.games_played(@previous_season).size
    assert_equal 4, @mark.games_played(@current_season).size
    assert_equal 0, @mark.games_played(@next_season).size
  end
  
  test "wins" do
    assert_equal 3, @mark.wins
    assert_equal 2, @mark.wins(@current_season)    
  end
  
  test "defeats" do
    assert_equal 2, @mark.defeats
    assert_equal 1, @mark.defeats(@current_season)
  end
  
  test "tied games" do
    assert_equal 1, @mark.tied_games
    assert_equal 1, @mark.tied_games(@current_season)
  end
  
  test "goal against average" do
    assert_equal 4.5, @mark.goal_against_average(@previous_season)
    assert_equal 3.5, @mark.goal_against_average(@current_season)
    assert_equal 3.83, @mark.goal_against_average
  end
  
  test "goals against" do
    assert_equal 9, @mark.goals_against(@previous_season)
    assert_equal 14, @mark.goals_against(@current_season)
    assert_equal 23, @mark.goals_against
  end
  
  test "assists of a player" do
    assert_equal 2, @pascal.assists
    assert_equal 2, @pascal.assists(@previous_season)
    assert_equal 0, @pascal.assists(@current_season)
    assert_equal 0, @pascal.assists(@next_season)
  end
  
  test "goals of a player" do
    assert_equal 5, @pascal.goals
    assert_equal 2, @pascal.goals(@previous_season)
    assert_equal 3, @pascal.goals(@current_season)
    assert_equal 0, @pascal.goals(@next_season)
  end
  
  test "points per game" do
    assert_equal 1.17, @pascal.points_per_game
    assert_equal 2, @pascal.points_per_game(@previous_season)
    assert_equal 0.75, @pascal.points_per_game(@current_season)
    assert_equal 0, @pascal.points_per_game(@next_season)
  end
  
end
