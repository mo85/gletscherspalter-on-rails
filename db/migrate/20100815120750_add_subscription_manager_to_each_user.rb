class AddSubscriptionManagerToEachUser < ActiveRecord::Migration
  def self.up
    User.all.each do |u|
      unless u.subscription_manager
        s = SubscriptionManager.create(:user => u)
      end
    end
  end

  def self.down
    User.all.each { |u| u.subscription_manager.delete if u.subscription_manager }
  end
end
