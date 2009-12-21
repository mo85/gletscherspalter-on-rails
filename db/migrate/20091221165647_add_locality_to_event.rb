class AddLocalityToEvent < ActiveRecord::Migration
  def self.up
    add_column :events, :locality, :string
  end

  def self.down
    remove_column :events, :locality 
  end
end
