class News < ActiveRecord::Base
  belongs_to :user
  
  validates_presence_of :message, :user_id
  
  default_scope order('created_at DESC')
end
