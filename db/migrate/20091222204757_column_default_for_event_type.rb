class ColumnDefaultForEventType < ActiveRecord::Migration
  def self.up
    change_column_default :events, :type, "Event"
  end

  def self.down
    change_column :events, :type, :string, :default => nil
  end
end
