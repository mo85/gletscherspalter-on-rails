class Avatar < ActiveRecord::Base
  
  belongs_to :user
  
  has_attached_file :photo, :styles => { :medium => "200x400>", :thumb => "50x50>" }
  
end
