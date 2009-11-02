require 'test_helper'

class PlayerTest < ActiveSupport::TestCase
  def setup
    @player = Player.new
  end
  
  test "player creation" do
  
  end
  
  test "invalid positions" do
    # invalid_pos = ["Forwards", "aösldk", "fo", "backs", "goalers"]
    # invalid_pos.each do |pos|
    #   player = Player.new(:name => "test",
    #                       :number => 99,
    #                       :position => pos)
    #   assert !player.valid?
    # end
  end
  
end
