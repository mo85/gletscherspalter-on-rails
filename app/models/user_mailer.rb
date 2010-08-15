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
  
  def new_news(news_entry)
    users = User.all.select{|u| u.email != nil && u.email != ""}
    
    if RAILS_ENV == "production"
      bcc users.collect{|u| "#{u.name} <#{u.email}>"}
    else
      bcc users.collect{|u| "#{u.name} <mark_odermatt@bluewin.ch>"}
    end
    
    from          "no-reply@gletscherspalter.ch"
    subject       "Neuigkeiten auf Gletscherspalter.ch"
    body          :creator => news_entry.user, :message => news_entry.message
    content_type  "text/html"
  end
  
  def new_comment(event)
    last_comment = event.comments.last
    message = last_comment.comment
    creator_of_last_comment = last_comment.user
    users = event.comments.collect(&:user).uniq - [creator_of_last_comment]
    
    if users.size > 0
      if RAILS_ENV == "production"
        bcc users.collect{|u| "#{u.name} <#{u.email}>"}
      else
        bcc users.collect{|u| "#{u.name} <mark_odermatt@bluewin.ch>"}
      end
    
      from          "no-reply@gletscherspalter.ch"
      subject       "Neuer Kommentar"
      body          :creator => creator_of_last_comment, :message => message, :event => event
      content_type  "text/html"
    end
  end

end
