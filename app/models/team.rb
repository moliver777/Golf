class Team < ActiveRecord::Base
	has_many :team_pro_mappings
	has_many :pros, :through => :team_pro_mappings
	
	def score
		scores = self.pros.map{|pro| pro.score}
		sum = scores.inject{|sum,x|sum+x}
		return (pros.count < 4 ? sum : sum-scores.min)
	end
end
