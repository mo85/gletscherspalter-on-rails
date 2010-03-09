class AddUserIdToUserPic < ActiveRecord::Migration
  def self.up
    add_column :user_pictures, :user_id, :integer
  end

  def self.down
    remove_column :user_pictures, :user_id
  end
end
