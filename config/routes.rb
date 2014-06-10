Golf::Application.routes.draw do
  root :to => "application#index"
  
  get "/get_teams" => "application#get_teams"
  get "/get_pros" => "application#get_pros"
end
