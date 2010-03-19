# Settings specified here will take precedence over those in config/environment.rb

# In the development environment your application's code is reloaded on
# every request.  This slows down response time but is perfect for development
# since you don't have to restart the webserver when you make code changes.
config.cache_classes = false

# Log error messages when you accidentally call methods on nil.
config.whiny_nils = true

# Show full error reports and disable caching
config.action_controller.consider_all_requests_local = true
config.action_view.debug_rjs                         = true
config.action_controller.perform_caching             = false

#config.cache_store = :memory_store


config.action_mailer.raise_delivery_errors = true

config.action_mailer.delivery_method = :smtp

config.action_mailer.smtp_settings = {
  :address        => APP_CONFIG["mail"]["server"],
  :port           => 26,
  :domain         => APP_CONFIG["mail"]["domain"],
  :authentication => :login,
  :user_name       => APP_CONFIG["mail"]["user_name"],
  :password       => APP_CONFIG["mail"]["password"]
}