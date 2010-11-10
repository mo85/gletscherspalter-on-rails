require "development_mail_interceptor"

ActionMailer::Base.delivery_method = :smtp

# ActionMailer::Base.smtp_settings = {
#   :address              => 'smtp.gmail.com',
#   :port                 => 587,
#   :domain               => 'www.gletscherspalter.ch',
#   :user_name            => 'mark.odermatt',
#   :password             => 'my password',
#   :authentication       => "plain",
#   :enable_starttls_auto => true
# }

ActionMailer::Base.smtp_settings = {
    :address        => APP_CONFIG["mail"]["server"],
    :port           => 26,
    :domain         => APP_CONFIG["mail"]["domain"],
    :user_name       => APP_CONFIG["mail"]["user_name"],
    :password       => APP_CONFIG["mail"]["password"],
    :authentication => :login,
    :enable_starttls_auto => false
}

ActionMailer::Base.default_url_options[:host] = "www.gletscherspalter.ch"

ActionMailer::Base.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?