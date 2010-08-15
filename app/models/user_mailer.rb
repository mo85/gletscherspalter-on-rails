class UserMailer < ActionMailer::Base
  def mail_news(user, message)
    if RAILS_ENV == "production"
      bcc user.collect{|u| "#{u.name} <#{u.email}>"}
    else
      bcc user.collect{|u| "#{u.name} <mark_odermatt@bluewin.ch>"}
    end
    
    from          "no-reply@gletscherspalter.ch"
    subject       message.subject
    body          "#{message.text}"
    content_type  "text/html"
  end
  
  def new_news(creator, message)
    users = User.all.select{|u| u.email != nil && u.email != ""}
    
    if RAILS_ENV == "production"
      bcc users.collect{|u| "#{u.name} <#{u.email}>"}
    else
      bcc users.collect{|u| "#{u.name} <mark_odermatt@bluewin.ch>"}
    end
    
    from          "no-reply@gletscherspalter.ch"
    subject       "Neuigkeiten auf Gletscherspalter.ch"
    body          :creator => creator, :message => message
    content_type  "text/html"
  end

end
