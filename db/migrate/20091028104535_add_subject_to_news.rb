class AddSubjectToNews < ActiveRecord::Migration
  def self.up
    add_column(:news, :subject, :string)
  end

  def self.down
    remove_column(:news, :subject)
  end
end
