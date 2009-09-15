class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :title
      t.datetime :date
      t.string :location
      t.text :note

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
