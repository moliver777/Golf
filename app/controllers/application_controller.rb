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
  
  private
  
  def setup
    @prev_score = 0
    @prev_position = 0
    @team_par = SiteSetting.where("key = ?", "team_par").first.value.to_i rescue 144
    @pro_par = SiteSetting.where("key = ?", "pro_par").first.value.to_i rescue 72
    @interval = SiteSetting.where("key = ?", "interval").first.value.to_i rescue 5000
  end
end
