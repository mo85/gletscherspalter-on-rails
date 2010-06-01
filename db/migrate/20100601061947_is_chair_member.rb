class IsChairMember < ActiveRecord::Migration
  def self.up
    add_column :users, :is_chair_member, :boolean
  end

  def self.down
    remove_column :users, :is_chair_member
  end
end
