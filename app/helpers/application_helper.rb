module ApplicationHelper
  
  def javascript(*args)
    content_for(:javascripts) { javascript_include_tag(*args) }
  end
  
  def include_tinymce
    javascript("tiny_mce/tiny_mce")
  end
  
  def format_date(date)
    "#{date.strftime('%d. %B %Y - %H:%M')}"
  end

  def user_profile_pic_old user, size = :thumb
    filename = "/images/profile_thumb.png"

    if user && user.user_picture
      filename = user.user_picture.public_filename(size)
    end

    "<img src='#{filename}' />"
  end

  def user_profile_pic user, size = :thumb
    size ||= :medium
    
    file = "/images/profile_thumb.png"
    if user && user.avatar && user.avatar.photo.url
      file = user.avatar.photo.url(size)
    end
    
    image_tag file
    
  end
  
  
end
