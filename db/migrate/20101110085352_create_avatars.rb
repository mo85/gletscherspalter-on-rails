class CreateAvatars < ActiveRecord::Migration
  def self.up
    create_table :avatars do |t|
      t.integer :user_id
      
      t.string :photo_file_name
      t.string :photo_content_type
      t.string :photo_file_size
      t.datetime :photo_updated_at
      
      t.timestamps
    end
  end

  def self.down
    drop_table :avatars
  end
end
