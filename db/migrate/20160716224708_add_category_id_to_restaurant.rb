class AddCategoryIdToRestaurant < ActiveRecord::Migration
  def change
    add_column :restaurants, :category_id, :integer
    add_index :restaurants, :category_id
  end
end
