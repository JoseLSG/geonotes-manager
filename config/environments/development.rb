Geonotes::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the webserver when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  # config.action_view.debug_rjs             = true # removed for rails 3.1.3 upgrade
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.delivery_method = :smtp
  
  # needs correct ip for ur app server
  config.action_mailer.default_url_options = { :host => 'localhost:3000' }
  
  # needs correct settings for your dev smtp server 
  config.action_mailer.smtp_settings = {
    :address => 'smtp.gmail.com',
    :domain => 'gmail.com',
    :port => 587,
    :user_name => 'REPLACE WITH EMAIL',
    :password => 'REPLACE WITH EMAIL PASSWORD',
    :authentication => 'plain',
    :enable_starttls_auto => true
  }

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin
  
# rails 3.2.2 upgrade
  # Raise exception on mass assignment protection for Active Record models
  config.active_record.mass_assignment_sanitizer = :strict
   
  # Log the query plan for queries taking more than this (works
  # with SQLite, MySQL, and PostgreSQL)
  config.active_record.auto_explain_threshold_in_seconds = 0.5
end

