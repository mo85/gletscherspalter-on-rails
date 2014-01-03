class Avatar < ActiveRecord::Base
  
  belongs_to :user
  
  has_attached_file :photo, :styles => { :medium => "200x400>", :thumb => "50x50>" },
  :storage => :s3,
  :path => "assets/:class/:id/:style/:filename",
  :s3_credentials => "#{Rails.root}/config/amazon_s3.yml",
  :bucket => "gletscherspalter_on_rails_#{Rails.env}"
  
end
