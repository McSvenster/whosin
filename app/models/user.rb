class User < ActiveRecord::Base

  has_secure_password
  has_many :attendances
  has_many :plans, through: :attendances
    
  scope :aktuell,->{where(geloescht: false)}

end
