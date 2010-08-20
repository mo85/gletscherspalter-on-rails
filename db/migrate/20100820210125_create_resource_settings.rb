class CreateResourceSettings < ActiveRecord::Migration
  def self.up
    create_table :resource_settings, :force => true do |t|
      t.integer :user_id
      t.integer :resource_id
      t.string  :resource_type
      
      t.boolean :comments_expanded, :default => false
      
      t.timestamps
    end
  end

  def self.down
    drop_table :resource_settings
  end
end
