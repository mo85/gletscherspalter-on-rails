require "base64"

module RootHelper
  
  def encode_mail(address)
    Base64.encode64(address)
  end
  
  def lightbox_history_img(filename, options)
    options[:class] ||= "nil"
    options[:filetype] ||= "jpg"
    
    html = "<a href='/images/history/#{filename}-middle.#{options[:filetype]}' rel='lightbox[roadtrip]'>"
    html += image_tag("history/#{filename}-small.#{options[:filetype]}", :class => "#{options[:class]}")
    html += "</a>"
  end
  
end
