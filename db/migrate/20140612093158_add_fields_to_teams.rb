class AddFieldsToTeams < ActiveRecord::Migration
  def change
    rename_column :teams, :name, :amateur_1
    add_column :teams, :amateur_2, :string
    add_column :teams, :amateur_3, :string
    add_column :teams, :pro_id, :integer
  end
end
