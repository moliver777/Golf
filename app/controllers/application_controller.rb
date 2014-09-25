class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :setup
  
  def index
    teams = Team.all.map{|team| expand_team(team)}
    teams.sort!{|a,b| b["score"]-a["score"]}
    @teams = teams.select{|team| team["score"] != 0}+teams.select{|team| team["score"] == 0}.sort{|a,b| a["tee_time"] - b["tee_time"]}
  end
  
  def get_teams
    teams = Team.all.map{|team| expand_team(team)}
    teams.sort!{|a,b| b["score"]-a["score"]}
    @teams = teams.select{|team| team["score"] != 0}+teams.select{|team| team["score"] == 0}.sort{|a,b| a["tee_time"] - b["tee_time"]}
    render :partial => "teams"
  end
  
  def get_pros
    @pros = Pro.where("score > 0").order("score DESC, name ASC").limit(15)
		if @pros.first
    	render :partial => "pros"
		else
	    teams = Team.all.map{|team| expand_team(team)}
	    teams.sort!{|a,b| b["score"]-a["score"]}
	    @teams = teams.select{|team| team["score"] != 0}+teams.select{|team| team["score"] == 0}.sort{|a,b| a["tee_time"] - b["tee_time"]}
	    render :partial => "teams"
		end
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
    xteam = team.attributes
		xteam["pro1"] = team.pros[0].name rescue nil
		xteam["pro2"] = team.pros[1].name rescue nil
		xteam["pro3"] = team.pros[2].name rescue nil
		xteam["pro4"] = team.pros[3].name rescue nil
    xteam
  end
end
