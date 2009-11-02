class UserMailer < ActionMailer::Base
  def mail_news(user, message)
    if RAILS_ENV == "production"
      bcc user.collect{|u| "#{u.full_name} <#{u.email}>"}
    else
      bcc user.collect{|u| "#{u.full_name} <mark_odermatt@bluewin.ch>"}
    end
    
    from          "no-reply@gletscherspalter.ch"
    subject       message.subject
    body          "#{message.text}"
    content_type  "text/html"
  end

end
