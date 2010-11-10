class DropTableUserPictures < ActiveRecord::Migration
  def self.up
    drop_table :user_pictures
  end

  def self.down
    create_table :user_pictures
  end
end
