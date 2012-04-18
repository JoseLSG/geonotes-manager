# == Schema Information
#
# Table name: users
#
#  id                     :integer(4)      not null, primary key
#  email                  :string(255)     default(""), not null
#  encrypted_password     :string(128)     default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer(4)      default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  authentication_token   :string(255)
#  created_at             :datetime        not null
#  updated_at             :datetime        not null
#  username               :string(255)
#

# NOTE: to enable email confirmation, uncomment :confirmable symbole on function 'devise'
#       AND make sure ur development.rb or production.rb have the mailer smtp server config setup correctly for your system
class User < ActiveRecord::Base
  has_many :notes, :dependent => :destroy
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, #:confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable, :authentication_keys => [:login]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :login, :username, :email, :password, :password_confirmation, :remember_me
  
  attr_accessor :login
  
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.strip.downcase }]).first
  end
 
   protected
  
   # Attempt to find a user by it's email. If a record is found, send new
   # password instructions to it. If not user is found, returns a new user
   # with an email not found error.
   def self.send_reset_password_instructions(attributes={})
     recoverable = find_recoverable_or_initialize_with_errors(reset_password_keys, attributes, :not_found)
     recoverable.send_reset_password_instructions if recoverable.persisted?
     recoverable
   end 
  
   def self.find_recoverable_or_initialize_with_errors(required_attributes, attributes, error=:invalid)
     (case_insensitive_keys || []).each { |k| attributes[k].try(:downcase!) }
  
     attributes = attributes.slice(*required_attributes)
     attributes.delete_if { |key, value| value.blank? }
  
     if attributes.size == required_attributes.size
       if attributes.has_key?(:login)
          login = attributes[:login]
          record = find_record(login)
       else  
         record = where(attributes).first
       end  
     end  
  
     unless record
       record = new
  
       required_attributes.each do |key|
         value = attributes[key]
         record.send("#{key}=", value)
         record.errors.add(key, value.present? ? error : :blank)
       end  
     end  
     record
   end
  
   def self.find_record(login)
     where(["username = :value OR email = :value", { :value => login }]).first
   end
 
end
