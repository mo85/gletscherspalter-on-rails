class DevelopmentMailInterceptor
  
  def self.delivering_email(message)
    message.subject = "#{message.to} #{message.subject}"
    message.to = "mark_odermatt@bluewin.ch"
  end

end
