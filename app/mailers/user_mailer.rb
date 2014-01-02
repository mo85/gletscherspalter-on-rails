class UserMailer < ActionMailer::Base
  default :from => "no-reply@gletscherspalter.ch"
  
  def mail_message(user, message)
    result = nil
    @message = message
    addresses = collect_addresses(user)
    if (addresses.any?)
      result = mail(:to => addresses, :subject => message.subject)
    end
    result
  end
  
  def new_news(news_entry)
    result = nil
    users = User.all.select{|u| u.email != nil && u.email != ""}
    users = users.select{ |u| u.subscription_manager.news == true }
    @creator = news_entry.user
    @message = news_entry.message
    
    addresses = collect_addresses(users)
    if (addresses.any?)
      result = mail(:to => addresses, :subject => "Neuigkeiten auf Gletscherspalter.ch")
    end
    result
  end
  
  def new_comment(comment, event, users)
    result = nil
    @creator = comment.user
    @message = comment.comment
    @event = event
    
    addresses = collect_addresses(users)
    if (addresses.any?)
      result = mail(:to => addresses, :subject => "Neuer Kommentar")
    end
    result
  end
  
  def new_supporter supporter
    result = nil
    @supporter = supporter
    users = User.where("is_admin = ? OR is_chair_member = ?", true, true).uniq
    addresses = collect_addresses(users)
    if (addresses.any?)
      result = mail(:to => addresses, :subject => "Neuer Supporter auf Gletscherspalter.ch registriert!")
    end
    result
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
