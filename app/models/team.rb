class Team < ActiveRecord::Base
	belongs_to :pro
  
	validates :score, numericality: true
end
