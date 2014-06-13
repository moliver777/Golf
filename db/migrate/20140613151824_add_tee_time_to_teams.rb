class AddTeeTimeToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :tee_time, :time, :null => false, :default => "00:00:00"
  end
end
