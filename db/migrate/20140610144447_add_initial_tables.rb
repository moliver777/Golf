class AddInitialTables < ActiveRecord::Migration
  def up
    create_table :pros do |t|
      t.string :name, :null => false
      t.integer :score, :null => false, :default => 0
      t.timestamps
    end
    
    create_table :teams do |t|
      t.string :name, :null => false
      t.timestamps
    end
    
    create_table :site_settings do |t|
      t.string :key, :null => false
      t.string :value, :null => false
      t.timestamps
    end
  end

  def down
    drop_table :pros
    drop_table :teams
    drop_table :site_settings
  end
end
