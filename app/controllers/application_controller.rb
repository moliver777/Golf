class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :setup
  
  def index
    teams = Team.all.map{|team| expand_team(team)}
    teams.sort!{|a,b| a["total_score"]-b["total_score"]}
    @teams = teams.select{|team| team["total_score"] != 0}+teams.select{|team| team["total_score"] == 0}.sort{|a,b| a["pro"]["name"] <=> b["pro"]["name"]}
  end
  
  def get_teams
    teams = Team.all.map{|team| expand_team(team)}
    teams.sort!{|a,b| a["total_score"]-b["total_score"]}
    @teams = teams.select{|team| team["total_score"] != 0}+teams.select{|team| team["total_score"] == 0}.sort{|a,b| a["pro"]["name"].downcase <=> b["pro"]["name"].downcase}
    render :partial => "teams"
  end
  
  def get_pros
    @pros = Pro.where("score > 0").order("score ASC, name ASC")+Pro.where("score = 0").order("name ASC")
    render :partial => "pros"
  end
	
  def get_image
    team = Team.find(params[:id])
    @image = team.image
    send_data @image, :disposition => 'inline'
  end
  
  private
  
  def setup
    @prev_score = 0
    @prev_position = 0
    @pro_par = SiteSetting.where("config_key = ?", "pro_par").first.config_value.to_i rescue 72
    @team_par = SiteSetting.where("config_key = ?", "team_par").first.config_value.to_i rescue 144
    @interval = (SiteSetting.where("config_key = ?", "interval").first.config_value.to_i*1000) rescue 30000
  end
  
  def expand_team team
    pro = team.pro
    xteam = team.attributes
    xteam["pro"] = pro.attributes
    xteam
  end
end
