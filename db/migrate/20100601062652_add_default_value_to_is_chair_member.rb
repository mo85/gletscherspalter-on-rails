class AddDefaultValueToIsChairMember < ActiveRecord::Migration
  def self.up
    change_column_default(:users, :is_chair_member, false)
  end

  def self.down
    change_column_default(:users, :is_chair_member, nil)
  end
end
