class User < ActiveRecord::Base

  has_secure_password
  
  scope :aktuell,->{where(geloescht: false)}
end
