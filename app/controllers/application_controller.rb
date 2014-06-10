class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def index
    # @teams = Team.where("score > 0").order("score ASC, name ASC")+Team.where("score = 0").order("name ASC")
  end
  
  def get_teams
    # @teams = Team.where("score > 0").order("score ASC, name ASC")+Team.where("score = 0").order("name ASC")
    render :partial => "teams"
  end
  
  def get_pros
    # @pros = Pro.where("score > 0").order("score ASC, name ASC")+Pro.where("score = 0").order("name ASC")
    render :partial => "pros"
  end
end
