class Participation < ActiveRecord::Base
  belongs_to :milestone
  belongs_to :user
  belongs_to :peak
end
