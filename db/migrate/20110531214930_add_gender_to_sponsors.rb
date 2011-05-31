class AddGenderToSponsors < ActiveRecord::Migration
  def self.up
    add_column :sponsors, :gender, :string
  end

  def self.down
    remove_column :sponsors, :gender
  end
end
