# GeoNotes Manager: sample application

This sample application allows registered users to add, remove, and edit notes which they can place on geographical map. Also allows to add tag words to the notes for filtering capabilities.

Main open source technologies used:

* Leaflet
* Devise
* jQuery-mobile
* rGeo

##Installation notes

Git clone this repo and if you want confirmation email to work, you will need to:
1. Commented back in the :confirmable symbole in user.rb
2. Add smtp server details and app host ip in development.rb

Example:
```ruby
#user.rb
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
         
#development.rb

  config.action_mailer.default_url_options = { :host => 'http://1.1.1.1:3000' }
  
#using gmail account to send email
 
  config.action_mailer.smtp_settings = {
    :address => 'smtp.gmail.com',
    :domain => 'gmail.com',
    :port => 587,
    :user_name => 'your.email@gmail.com',
    :password => 'youremailpassword',
    :authentication => 'plain',
    :enable_starttls_auto => true
  }
```