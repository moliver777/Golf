class TeamProMapping < ActiveRecord::Base
	belongs_to :team
	belongs_to :pro
end
