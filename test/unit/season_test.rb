require 'test_helper'

class SeasonTest < ActiveSupport::TestCase
  
  fixtures :seasons
  fixtures :events
  
  def setup
    @previous_season = seasons(:previous)
    @current_season = seasons(:actual)
    @next_season = seasons(:next)
  end
  
  def teardown
    season_to_delete = Season.find_by_start_year_and_end_year(2011, 2012)
    if season_to_delete
      Season.delete season_to_delete
    end
    assert_equal 3, Season.count
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
    s_2010_2011 = @next_season
    
    # August 2010 to July 2011
    assert_equal s_2010_2011, Season.current(Time.parse("2010/8/1"))
    assert_equal s_2010_2011, Season.current(Time.parse("2010/11/15"))
    assert_equal s_2010_2011, Season.current(Time.parse("2011/5/10"))
    assert_equal s_2010_2011, Season.current(Time.parse("2011/7/31"))
    
    # creation of a new season in August 2011
    newly_created_season = Season.current(Time.parse("2011/8/1"))
    assert_equal 2011, newly_created_season.start_year
    assert_equal 2012, newly_created_season.end_year
    
    assert_equal Season.find_by_start_year_and_end_year(2011,2012), newly_created_season
    
  end
  
end
