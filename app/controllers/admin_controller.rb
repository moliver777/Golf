class AdminController < ApplicationController
	
	skip_before_filter :setup, :except => [:index]
	layout 'admin'
	
  def index
		@success = nil	
		if params[:name]
			@search = params[:name]
			ids = Team.where("name LIKE ?", "%#{params[:name]}%").map{|team| team.id}
			ids += Pro.where("name LIKE ?", "%#{params[:name]}%").map{|pro| pro.team.id}
			@teams = Team.where(:id => ids).order("tee_time ASC")
		else
			@teams = Team.order("tee_time ASC")
		end
  end

	def add_team
		begin
			team = Team.create(:name => params[:name], :tee_time => "#{params[:tee_hour]}:#{params[:tee_mins]}:00")
			pro1 = Pro.create(:name => params[:pro1])
			pro2 = Pro.create(:name => params[:pro2])
			pro3 = Pro.create(:name => params[:pro3])
			pro4 = Pro.create(:name => params[:pro4])
			TeamProMapping.create(:team_id => team.id, :pro_id => pro1.id)
			TeamProMapping.create(:team_id => team.id, :pro_id => pro2.id)
			TeamProMapping.create(:team_id => team.id, :pro_id => pro3.id)
			TeamProMapping.create(:team_id => team.id, :pro_id => pro4.id)
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
			render :json => {:success => true, :score => @pro.team.score}
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
    team.update_attributes({:name => params[:name], :tee_time => "#{params[:tee_hour]}:#{params[:tee_mins]}:00"})
		team.pros.each_with_index do |pro,i|
			pro.update_attributes({:name => params["pro#{i+1}"]})
		end
    render :json => {:success => true}
  rescue StandardError => e
    puts e.message
    puts e.backtrace
    render :json => {:success => false}
  end
  
	def delete_team
		begin 
			@team = Team.find(params[:id])
			@mappings = @team.team_pro_mappings
			@pros = Pro.where(:id => @mappings.map{|mapping| mapping.pro_id})
			@mappings.destroy_all
			@pros.destroy_all
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
