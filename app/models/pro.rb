class Pro < ActiveRecord::Base
	has_one :team
  
	validates :score, numericality: true
end
