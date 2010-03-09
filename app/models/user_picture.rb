require 'digest/sha1'

class UserPicture < ActiveRecord::Base
  belongs_to :user

  has_attachment :content_type => :image,
                 :storage => :file_system,
                 :resize_to => '200x400>',
                 :thumbnails => { :thumb => "50x50^" },
                 :partition => false,
                 :path_prefix => "public/users",
                 :processor => "mini_magick"

  validates_as_attachment

  before_create :set_filename
  after_save :crop_thumbnail

  private

  def crop_thumbnail
    if parent_id.blank?
      file = "#{RAILS_ROOT}/public#{public_filename(:thumb)}"
      `mogrify -gravity center -crop 50x50+0+0 +repage #{file}`
    end
  end

  def set_filename
    if parent_id.blank?
      suffix = self.filename.split(".").last
      self.filename = "#{Digest::SHA1.hexdigest(Time.now.to_s.split(//).sort_by{ rand }.join)}.#{suffix}"
    end
  end
                 
end
