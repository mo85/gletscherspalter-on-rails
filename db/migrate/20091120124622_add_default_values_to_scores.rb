class AddDefaultValuesToScores < ActiveRecord::Migration
  def self.up
    change_column_default(:scores, :goals, 0)
    change_column_default(:scores, :assists, 0)
  end

  def self.down
    change_column_default(:scores, :goals, nil)
    change_column_default(:scores, :assists, nil)
  end
end
