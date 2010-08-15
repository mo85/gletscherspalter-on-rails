class CreateSubscriptionManagers < ActiveRecord::Migration
  def self.up
    create_table :subscription_managers do |t|
      t.boolean :comments, :default => 1
      t.boolean :news, :default => 1
      
      t.boolean :forum, :default => 1
      t.boolean :new_event, :default => 1
      t.boolean :event_changed, :default => 1
      
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :subscription_managers
  end
end
