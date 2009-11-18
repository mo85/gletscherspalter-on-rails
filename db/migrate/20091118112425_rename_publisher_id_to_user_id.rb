class RenamePublisherIdToUserId < ActiveRecord::Migration
  def self.up
    rename_column(:news, :publisher_id, :user_id)
  end

  def self.down
    rename_column(:news, :user_id, :publisher_id)
  end
end
