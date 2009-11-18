class CreateNewNews < ActiveRecord::Migration
  def self.up
    create_table :news do |t|
      t.integer   :publisher_id
      t.text      :message
      
      t.timestamps
    end
  end

  def self.down
    drop_table :news
  end
end
