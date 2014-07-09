class AddMoreFieldsToTeams < ActiveRecord::Migration
  def change
		add_column :teams, :amateur_4, :string
		add_column :teams, :name, :string
  end
end
