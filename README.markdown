# GeoNotes Manager: sample application ( in progress )

This sample application allows registered users to add, remove, and edit notes which they can place on a geographical map. 
Also allows to add tag words to the notes for filtering capabilities.

* Note: meant for mobile devices first.

Features:

- Taggable notes
- Basic filtering of map notes by their tags
- Allows for quick lookup of notes on map from Notes page
- Location detection for each note added


Main open source technologies used:

* Leaflet
* Devise
* jQuery-mobile
* GeoNames (web service)
* HTTParty
* rGeo (Removed: uses activerecord-mysql2spatial-adapter gem which causes conflicts with rails 3.2.)
* Mysql

* Note: originally developped on Rails 3.0.11 and then upgraded to 3.1.3 follow by 3.2.2

##Installation notes

Git clone this repo and if you want confirmation email to work, you will need to:

1. Commented back in the :confirmable symbole in user.rb
2. Add smtp server details and app host ip in development.rb

Example:


user.rb

    devise :database_authenticatable, :registerable, :confirmable,
           :recoverable, :rememberable, :trackable, :validatable

development.rb

    config.action_mailer.default_url_options = { :host => '1.1.1.1:3000' }
  
using gmail account to send email
 
    config.action_mailer.smtp_settings = {
      :address => 'smtp.gmail.com',
	    :domain => 'gmail.com',
	    :port => 587,
	    :user_name => 'your.email@gmail.com',
	    :password => 'youremailpassword',
	    :authentication => 'plain',
	    :enable_starttls_auto => true
	    }
