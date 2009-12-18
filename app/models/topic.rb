class Topic < ActiveRecord::Base
  has_many :posts, :order => "created_at DESC"
  
  belongs_to :owner, :class_name => "User", :foreign_key => "user_id"
  
  def last_post
    posts.first
  end
  
  def self.sort_topics(topics)
    topics.sort_by{ |t| t.last_post.created_at }.reverse
  end
end
