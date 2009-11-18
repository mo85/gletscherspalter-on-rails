class News < ActiveRecord::Base
  belongs_to :publisher, :class_name => "User"
  
  validates_presence_of :message, :user_id
end
