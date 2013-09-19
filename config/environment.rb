# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Cpwiki::Application.initialize!

# Configure ActionMailer to use my Gmail (MUST CHANGE IN PRODUCTION)  
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :address   => 'smtp.gmail.com',
  :domain    => 'cp-wiki.com',
  :port      => 587,
  :user_name => 'cpwikiproject',
  :password  => 'cpwiki2013',
  :authentication => :plain
}

ActionMailer::Base.raise_delivery_errors = true
