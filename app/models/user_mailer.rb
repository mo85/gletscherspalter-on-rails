class UserMailer < ActionMailer::Base
  def registration_confirmation(user)
    recipients    user.email
    from          "webmaster@gletscherspalter.ch"
    subject       "Thank you for Registration"
    body          :user => user
  end

end
