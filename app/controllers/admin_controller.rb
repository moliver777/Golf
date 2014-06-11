class AdminController < ApplicationController
	
	skip_before_filter :setup, :except => [:teams, :pros]
	layout 'admin'
	
	def teams
		@success = nil	
		if params[:name]
			@search = params[:name]
			@teams = Team.where("name like ?", "%#{params[:name]}%").order("name ASC")
		else
			@teams = Team.order("name ASC")
		end
	end
	
	def pros
		@success = nil	
		if params[:name]
			@search = params[:name]
			@pros = Pro.where("name like ?", "%#{params[:name]}%").order("name ASC")
		else
			@pros = Pro.order("name ASC")
		end
		
	end

	def add_pro
		if params[:image_form]
			begin 
				@pro = Pro.new(:name => params[:image_form][:pro_name], :image => params[:image_form][:image].read)
				if @pro.valid?
					@pro.save
					@success = "true"
				else
					@success = "false"
				end
			rescue StandardError => e
				@success = "false"
			end
			@pros = Pro.order("name ASC")
			render :pros
		else
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
		if params[:image_form]
			begin 
				@team = Team.new(:name => params[:image_form][:team_name], :image => params[:image_form][:image].read)
				if @team.valid?
					@team.save
					@success = "true"
				else
					@success = "false"
				end
			rescue StandardError => e
				@success = "false"
			end
			@teams = Team.order("name ASC")
			render :teams
		else
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
	
	def delete_team
		begin 
			@team = Team.find(params[:id])
			@id = @team.id
			@team.destroy
			render :json => {:success => true, :team_id => @id}
		rescue StandardError => e
			render :json => {:success => false}
		end
	end
	
	def delete_pro
		begin 
			@pro = Pro.find(params[:id])
			@id = @pro.id
			@pro.destroy
			render :json => {:success => true, :pro_id => @id}
		rescue StandardError => e
			render :json => {:success => false}
		end
	end
	
end
