# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper  
  
  def javascript(*args)
    content_for(:javascripts) { javascript_include_tag(*args) }
  end
  
  def include_tinymce
    javascript("tiny_mce/tiny_mce", "tiny_mce")
  end
  
  def format_date(date)
    "#{date.strftime('%d. %B %Y - %H:%M')}"
  end

end
