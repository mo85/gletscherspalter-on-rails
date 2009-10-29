class UserMailer < ActionMailer::Base
  def mail_news(users, news)
    if RAILS_ENV == "production"
      bcc users.collect{|u| "#{u.full_name} <#{u.email}>"}
    else
      bcc users.collect{|u| "#{u.full_name} <mark.odermatt@gmail.com"}
    end
    
    from          "noreply@gletscherspalter.ch"
    subject       news.subject
    body          news.message
    content_type  "text/html"
  end

end
