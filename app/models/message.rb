class Message < ActiveRecord::Base
  
  belongs_to :publisher, :class_name => "User", :foreign_key => "publisher_id"
  
  validates_presence_of :publisher, :message
  
end
