class CreateTeamProMappings < ActiveRecord::Migration
  def change
    create_table :team_pro_mappings do |t|
      t.integer :team_id, :null => false
      t.integer :pro_id, :null => false
      t.timestamps
    end
  end
end
