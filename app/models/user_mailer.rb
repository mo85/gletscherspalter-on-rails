class UserMailer < ActionMailer::Base
  def mail_news(users, news)
    if RAILS_ENV == "production"
      bcc users.collect{|u| "#{u.full_name} <#{u.email}>"}
    else
      bcc users.collect{|u| "#{u.full_name} <mark.odermatt@gmail.com>"}
    end
    
    from          "no-reply@gletscherspalter.ch"
    subject       news.subject
    body          :news => news
    content_type  "text/html"
  end

end
