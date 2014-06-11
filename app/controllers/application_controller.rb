class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :setup
  
  def index
    @teams = Team.where("score > 0").order("score ASC, name ASC")+Team.where("score = 0").order("name ASC")
  end
  
  def get_teams
    @teams = Team.where("score > 0").order("score ASC, name ASC")+Team.where("score = 0").order("name ASC")
    render :partial => "teams"
  end
  
  def get_pros
    @pros = Pro.where("score > 0").order("score ASC, name ASC")+Pro.where("score = 0").order("name ASC")
    render :partial => "pros"
  end
	
  def get_image
    if params[:type] == "pro"
      pro = Pro.find(params[:id])
      @image = pro.image
    elsif params[:type] == "team"
      team = Team.find(params[:id])
      @image = team.image
    end
    send_data @image, :disposition => 'inline'
  end
  
  private
  
  def setup
    @prev_score = 0
    @prev_position = 0
    @team_par = SiteSetting.where("key = ?", "team_par").first.value.to_i rescue 144
    @pro_par = SiteSetting.where("key = ?", "pro_par").first.value.to_i rescue 72
    @interval = SiteSetting.where("key = ?", "interval").first.value.to_i rescue 10000
  end
end
