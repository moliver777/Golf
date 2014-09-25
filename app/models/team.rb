class Team < ActiveRecord::Base
	has_many :team_pro_mappings
	has_many :pros, :through => :team_pro_mappings
end
