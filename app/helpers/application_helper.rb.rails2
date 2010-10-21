# Methods added to this helper will be available to all templates in the application.
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

  def user_profile_pic user, size = :thumb
    filename = "/images/profile_thumb.png"

    if user && user.user_picture
      filename = user.user_picture.public_filename(size)
    end

    "<img src=\"#{filename}\" alt=\"\" />"
  end

end
