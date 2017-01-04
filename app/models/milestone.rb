class Milestone < ActiveRecord::Base
  belongs_to :project
  has_many :participations
  has_many :users, through: :participations
end
