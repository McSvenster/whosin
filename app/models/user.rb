class User < ActiveRecord::Base

  has_secure_password
  has_many :attendances
  has_many :plans, through: :attendances
    
  scope :aktuell,->{where(geloescht: false)}

  def blockdatenreset
    if self.kader
      self.blockdaten = ""
    else
      self.blockdaten = "24.12. - 31.12."
    end
    self.save
  end

end
