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
#config.action_controller.perform_caching             = false

# 2010-01-30 - brian.scott.warren@gmail.com
# Enable page caching to test domain-specific caching
config.action_controller.perform_caching             = true

# Mailer settings
config.action_mailer.raise_delivery_errors = true
config.action_mailer.perform_deliveries = true
config.action_mailer.delivery_method = :smtp
config.action_mailer.default_charset = "utf-8"

# SMTP settings
# NOTE: Postfix is configured to relay mail that originates from networks
# determined by the "mynetworks" parameter in postfix's config file
# /etc/postfix/main.cf
config.action_mailer.smtp_settings = {
  :address          => 'luna.qlogicinc.com',
  :port             => 25,
  :domain           => 'qlogicinc.com'
}
