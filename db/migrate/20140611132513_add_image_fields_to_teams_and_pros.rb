class AddImageFieldsToTeamsAndPros < ActiveRecord::Migration
  def change
    add_column :pros, :image, :binary
		add_column :teams, :image, :binary
  end
end
