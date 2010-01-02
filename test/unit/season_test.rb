require 'test_helper'

class SeasonTest < ActiveSupport::TestCase
  
  fixtures :seasons
  fixtures :games
  
  def setup
    @previous_season = seasons(:previous)
    @current_season = seasons(:actual)
    @next_season = seasons(:next)
  end
  
  
  test "games played" do
    assert_equal 2, @previous_season.games_played.size
    assert_equal 4, @current_season.games_played.size
    assert_equal 0, @next_season.games_played.size 
  end
  
  test "won games" do
    assert_equal 1, @previous_season.wins.size
    assert_equal 2, @current_season.wins.size
    assert_equal 0, @next_season.wins.size
  end
  
  test "tied games" do
    assert_equal 0, @previous_season.tied_games.size
    assert_equal 1, @current_season.tied_games.size
    assert_equal 0, @next_season.tied_games.size
  end
  
  test "games that we lost" do
    assert_equal 1, @previous_season.defeats.size
    assert_equal 1, @current_season.defeats.size
    assert_equal 0, @next_season.defeats.size
  end
  
  test "scored goals" do
    assert_equal 11, @previous_season.scored_goals
    assert_equal 12, @current_season.scored_goals
    assert_equal 0, @next_season.scored_goals
  end
  
  test "goals against" do
    assert_equal 9, @previous_season.goals_against
    assert_equal 14, @current_season.goals_against
    assert_equal 0, @next_season.goals_against
  end
  
  test "current season" do
    assert_true true
  end
  
end
