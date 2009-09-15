require 'test_helper'

class PlayerTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  
  def setup
    @player = Player.new
  end
  
  test "player creation" do
    assert !@player.valid?
    assert @player.errors.invalid?(:name)
    assert @player.errors.invalid?(:position)
    assert @player.errors.invalid?(:number)
  end
  
  test "valid posistions" do
    valid_pos = ["G", "FW", "BW"]
    valid_pos.each do |pos|
      player = Player.new(:name => "test",
                          :number => 0,
                          :position => pos)
      assert player.valid?
    end
  end
  
  test "invalid positions" do
    invalid_pos = ["Forwards", "aösldk", "fo", "backs", "goalers"]
    invalid_pos.each do |pos|
      player = Player.new(:name => "test",
                          :number => 99,
                          :position => pos)
      assert !player.valid?
    end
  end

  test "valid number" do
    player = Player.new(:name => "test",
                        :position => "FW",
                        :number => 0)
    assert player.valid?
  end
  
end
