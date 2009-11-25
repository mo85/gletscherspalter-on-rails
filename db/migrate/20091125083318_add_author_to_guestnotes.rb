class AddAuthorToGuestnotes < ActiveRecord::Migration
  def self.up
    add_column :guestnotes, :author, :string
  end

  def self.down
    remove_column :guestnotes, :author
  end
end
