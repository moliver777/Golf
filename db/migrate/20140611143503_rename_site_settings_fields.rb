class RenameSiteSettingsFields < ActiveRecord::Migration
  def change
    rename_column :site_settings, :key, :config_key
    rename_column :site_settings, :value, :config_value
  end
end
