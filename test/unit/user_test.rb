require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  test "user_and_player_creation" do
    @user = User.create(:login => "chris.stettler", :firstname => "chris", :lastname => "stettler")
    
    player = Player.find_by_user_id(@user.id)
    assert_not_nil player
    
    assert_equal "chris", player.user.firstname
    assert_equal "stettler", player.user.lastname
    assert_equal @user, player.user
  end
  
  test "is_player == false should not create a player" do
    @user = User.create(:login => "chris.stettler", :firstname => "chris", :lastname => "stettler", :is_player => false)

    player = Player.find_by_user_id(@user.id)
    assert_equal player, nil
  end
end
