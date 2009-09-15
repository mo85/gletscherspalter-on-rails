class CreateGames < ActiveRecord::Migration
  def self.up
    create_table :games do |t|
      t.datetime      :date
      t.integer       :location_id
      t.string        :opponent
      t.string        :result, :default => nil
      
      t.timestamps
    end
  end

  def self.down
    drop_table :games
  end
end
