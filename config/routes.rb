Golf::Application.routes.draw do
  root :to => "application#index"
  
  get "/get_teams" => "application#get_teams"
  get "/get_pros" => "application#get_pros"
  
  get "/get_image" => "application#get_image"
	
	get "/admin" => "admin#pros"
	get "/admin/teams" => "admin#teams"
	get "/admin/pros" => "admin#pros"
	
	post "/admin/add_pro"  => "admin#add_pro"
	post "/admin/update_score"  => "admin#update_pro_score"
	post "/admin/delete_pro"  => "admin#delete_pro"
	
	post "/admin/add_team"  => "admin#add_team"
	post "/admin/update_team_score"  => "admin#update_team_score"
	post "/admin/delete_team"  => "admin#delete_team"
	
end
