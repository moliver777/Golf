Golf::Application.routes.draw do
  root :to => "application#index"
  
  get "/get_teams" => "application#get_teams"
  get "/get_pros" => "application#get_pros"
  get "/get_image" => "application#get_image"
	
	get "/admin" => "admin#index"
	post "/admin/add_team"  => "admin#add_team"
  post "/admin/update_pro_score"  => "admin#update_pro_score"
	post "/admin/delete_team"  => "admin#delete_team"
  get "/admin/add_image/:id" => "admin#add_image"
  post "/admin/add_image/:id" => "admin#save_image"
  post "/admin/delete_image" => "admin#delete_image"
  get "/admin/edit/:id" => "admin#edit_team"
  post "/admin/update_team" => "admin#update_team"
end
