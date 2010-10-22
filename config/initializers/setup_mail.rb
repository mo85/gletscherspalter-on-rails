require "development_mail_interceptor"

ActionMailer::Base.delivery_method = :smtp

ActionMailer::Base.smtp_settings = {
  :address              => 'mail.gletscherspalter.ch',
  :port                 => 25,
  :domain               => 'mail.gletscherspalter.ch',
  :user_name            => 'no-reply+gletscherspalter.ch',
  :password             => '-p?!?fYvdivU',
  :authentication       => :login
}

if Rails.env.production?
  ActionMailer::Base.default_url_options[:host] = "www.gletscherspalter.ch"
else
  ActionMailer::Base.default_url_options[:host] = "localhost:3000"
end

ActionMailer::Base.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?