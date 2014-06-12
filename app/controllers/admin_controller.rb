class AdminController < ApplicationController
	
	skip_before_filter :setup, :except => [:index]
	layout 'admin'
	
  def index
		@success = nil	
		if params[:name]
			@search = params[:name]
      @pros = Pro.where("name LIKE ?", "%#{params[:name]}%")
			@teams = Team.includes(:pro).where("teams.amateur_1 LIKE ? OR teams.amateur_2 LIKE ? OR teams.amateur_3 LIKE ? OR teams.pro_id IN (?)", "%#{params[:name]}%", "%#{params[:name]}%", "%#{params[:name]}%", @pros.map{|pro| pro.id}).order("pros.name ASC")
		else
			@teams = Team.includes(:pro).order("pros.name ASC")
		end
  end

	def add_team
		begin
      @pro = Pro.new(:name => params[:pro])
      @pro.save!
			@team = Team.new(:pro_id => @pro.id, :amateur_1 => params[:amateur_1], :amateur_2 => params[:amateur_2], :amateur_3 => params[:amateur_3])
			@team.save!
      @teams = Team.includes(:pro).order("pros.name ASC")
			render :json => {:success => true, :view => render_to_string(:partial => "team_table")}
		rescue StandardError => e
			render :json => {:success => false}
		end
	end
	
	def update_pro_score
		begin 
			@pro = Pro.find(params[:pro_id])
			@pro.score = params[:score]
			@pro.save!
			render :json => {:success => true}
		rescue StandardError => e
			render :json => {:success => false}
		end
	end
  
	def update_amateur_score
		begin 
			@team = Team.find(params[:team_id])
			@team.score = params[:score]
			@team.save!
			render :json => {:success => true}
		rescue StandardError => e
			render :json => {:success => false}
		end
	end
	
	def delete_team
		begin 
			@team = Team.find(params[:id])
      @pro = @team.pro
			@id = @team.id
      @pro.destroy
			@team.destroy
			render :json => {:success => true, :team_id => @id}
		rescue StandardError => e
			render :json => {:success => false}
		end
	end
	
  def add_image
    @team = Team.find(params[:id])
  end
  
  def save_image
    @team = Team.find(params[:id])
    @team.image = params[:team_image][:image_file].read
    @team.save!
    redirect_to "/admin"
  end
end
