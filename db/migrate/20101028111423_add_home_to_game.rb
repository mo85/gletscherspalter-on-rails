class AddHomeToGame < ActiveRecord::Migration
  def self.up
    add_column :events, :home, :boolean, :default => nil
  end

  def self.down
    remove_column :events, :home
  end
end
