class CreateSubscriptionManagers < ActiveRecord::Migration
  def self.up
    create_table :subscription_managers do |t|
      t.boolean :comments, :default => false
      t.boolean :news, :default => false
      
      t.boolean :forum, :default => false
      t.boolean :new_event, :default => false
      t.boolean :event_changed, :default => false
      
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :subscription_managers
  end
end
