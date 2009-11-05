class AddMemberSinceFieldToPlayer < ActiveRecord::Migration
  def self.up
    add_column(:players, :member_since, :integer)
  end

  def self.down
    remove_column(:players, :member_since)
  end
end
