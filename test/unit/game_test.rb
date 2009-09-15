require 'test_helper'

class GameTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  
  fixtures :locations
  fixtures :games
  
  def setup
    @game = Game.new
  end
  
  test "creating games" do
    assert !@game.valid?
    assert @game.errors.invalid?(:location)
    assert @game.errors.invalid?(:opponent)
    assert_equal @game.result, nil
  end
  
  test "different result categories" do
    game_without_result = games(:jonasharks)
    assert game_without_result.valid?
    
    game_with_result = games(:bandenbysser)
    assert game_with_result.valid?
    
    valid_result = ["3:2", "100:1500"]
    
    valid_result.each do |result|
      new_game = Game.new(:opponent => "Bonecrashers",
                          :location => locations(:herti),
                          :result => result)
      assert new_game.valid?
    end
    
    
    # empty String passes!!!
    bad_result = ["3/7", "4:b", "b:c", "b:1", "test", "foo:13", "!", ".", "-", "12.5", "3-5"]
    
    bad_result.each do |result|
      new_game = Game.new(:opponent => "Bandenbysser",
                          :location => locations(:wetzikon),
                          :result => result)
      assert !new_game.valid?, "saving #{result}"
    end
  end
end
