# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Cpwiki::Application.initialize!

config.action_mailer.default_url_options = { :host => 'http://cpwiki-env-h4asjxuiwr.elasticbeanstalk.com/' }
# Configure ActionMailer to use my Gmail (MUST CHANGE IN PRODUCTION)  
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :address   => 'smtp.gmail.com',
  :domain    => 'cp-wiki.com',
  :port      => 587,
  :user_name => 'daitianxin',
  :password  => 'haiyan900822',
  :authentication => :plain
}

ActionMailer::Base.raise_delivery_errors = true
