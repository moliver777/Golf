class AdminController < ApplicationController
	
	skip_before_filter :setup, :except => [:index]
	layout 'admin'
	
  def index
		@success = nil	
		if params[:name]
			@search = params[:name]
			@teams = Team.where("name LIKE ? OR amateur_1 LIKE ? OR amateur_2 LIKE ? OR amateur_3 LIKE ? OR amateur_4 LIKE ?", "%#{params[:name]}%", "%#{params[:name]}%", "%#{params[:name]}%", "%#{params[:name]}%", "%#{params[:name]}%").order("tee_time ASC")
		else
			@teams = Team.order("tee_time ASC")
		end
  end

	def add_team
		begin
			@team = Team.new(:name => params[:name], :amateur_1 => params[:amateur_1], :amateur_2 => params[:amateur_2], :amateur_3 => params[:amateur_3], :amateur_4 => params[:amateur_4], :tee_time => "#{params[:tee_hour]}:#{params[:tee_mins]}:00")
			@team.save!
      @teams = Team.order("tee_time ASC")
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
			puts e.message
			puts e.backtrace
			render :json => {:success => false}
		end
	end
  
	def update_team_score
		begin 
			@team = Team.find(params[:team_id])
			@team.score = params[:score]
			@team.save!
			render :json => {:success => true}
		rescue StandardError => e
			puts e.message
			puts e.backtrace
			render :json => {:success => false}
		end
	end
	
  def edit_team
    @team = Team.find(params[:id])
  end
  
  def update_team
    team = Team.find(params[:id])
    team.update_attributes({name: params[:name], amateur_1: params[:amateur_1], amateur_2: params[:amateur_2], amateur_3: params[:amateur_3], amateur_4: params[:amateur_4], tee_time: "#{params[:tee_hour]}:#{params[:tee_mins]}:00"})
    render :json => {:success => true}
  rescue StandardError => e
    puts e.message
    puts e.backtrace
    render :json => {:success => false}
  end
  
	def delete_team
		begin 
			@team = Team.find(params[:id])
			@id = @team.id
			@team.destroy
			render :json => {:success => true, :team_id => @id}
		rescue StandardError => e
			puts e.message
			puts e.backtrace
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
  
  def delete_image
    @team = Team.find(params[:id])
    @team.image = nil
    @team.save!
    render :json => {:success => true}
  end
end
