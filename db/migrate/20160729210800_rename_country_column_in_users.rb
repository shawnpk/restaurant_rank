class RenameCountryColumnInUsers < ActiveRecord::Migration
  def change
    rename_column :users, :country, :state_provence
  end
end
