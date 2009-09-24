class ReduceUserAttributes < ActiveRecord::Migration
  def self.up
    remove_columns(:users, :first_name, :name, :user_name, :nick_name)
  end

  def self.down
    add_column(:users, :first_name, :string)
    add_column(:users, :name, :string)
    add_column(:users, :user_name, :string)
    add_column(:users, :nick_name, :string)
  end
end
