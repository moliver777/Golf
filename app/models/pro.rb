class Pro < ActiveRecord::Base
	has_one :team_pro_mapping
	has_one :team, :through => :team_pro_mapping
  
	validates :score, numericality: true
end
