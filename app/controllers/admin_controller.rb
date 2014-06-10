class AdminController < ApplicationController
	
	skip_before_filter :setup, :except => [:teams, :pros]
	layout 'admin'
	
	def teams
		 @teams = Team.order("name ASC")
	end
	
	def pros
		@pros = Pro.order("name ASC")
	end

	def add_pro
		begin 
			@pro = Pro.new(:name => params[:pro_name])
			if @pro.valid?
				@pro.save
				render :json => {:success => true, :pro => @pro}
			else
				render :json => {:success => false}
			end
		rescue StandardError => e
			render :json => {:success => false}
		end
	end
	
	def update_pro_score
		begin 
			@pro = Pro.find(params[:pro_id])
			@pro.score = params[:score]
			@pro.save!
			render :json => {:success => true, :pro => @pro}
		rescue StandardError => e
			render :json => {:success => false}
		end
	end
	
	def add_team
		begin 
			@team = Team.new(:name => params[:team_name])
			if @team.valid?
				@team.save
				render :json => {:success => true, :team => @team}
			else
				render :json => {:success => false}
			end
		rescue StandardError => e
			render :json => {:success => false}
		end
	end
	
	def update_team_score
		begin 
			@team = Team.find(params[:team_id])
			@team.score = params[:score]
			@team.save!
			render :json => {:success => true, :team => @team}
		rescue StandardError => e
			render :json => {:success => false}
		end
	end
	
end
