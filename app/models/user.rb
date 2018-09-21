class User < ActiveRecord::Base

  has_secure_password
  has_many :attendances
  has_many :plans, through: :attendances
    
  scope :aktuell,->{where(geloescht: 0)}

  # def blockdatenreset
  #   User.each do |u|
  #     if u.kader
  #       u.blockdaten = ""
  #     else
  #       u.blockdaten = "24.12. - 31.12."
  #     end
  #     u.save
  #   end
  # end

end
