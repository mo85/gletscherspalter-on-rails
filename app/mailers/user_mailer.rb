class UserMailer < ActionMailer::Base
  default :from => "no-reply@gletscherspalter.ch",
          :reply_to => 'admin@gletscherspalter.ch'
  
  def mail_message(user, message)
    @message = message
    puts
    puts collect_addresses(user)
    puts
    mail(:to => "mark.odermatt@gmail.com", :subject => message.subject)    
  end
  
  def new_news(news_entry)
    users = User.all.select{|u| u.email != nil && u.email != ""}
    users = users.select{ |u| u.subscription_manager.news == true }
    @creator = news_entry.user
    @message = news_entry.message
        
    mail(:bcc => collect_addresses(users), :subject => "Neuigkeiten auf Gletscherspalter.ch")
  end
  
  def new_comment(comment, event, users)
    @creator = comment.user
    @message = comment.comment
    @event = event
    
    mail(:bcc => collect_addresses(users), :subject => "Neuer Kommentar")
  end
  
  private
  
  def collect_addresses(recipients)
    result = nil
    if recipients.is_a?(User)
      result = recipients.email_with_name
    else
      result = recipients.collect{ |u| u.email_with_name }
    end
    result
  end

end
