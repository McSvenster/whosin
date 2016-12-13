class Milestone < ActiveRecord::Base
  belongs_to :projekt
  has_many :participations
  has_many :users, through: :participations
end
