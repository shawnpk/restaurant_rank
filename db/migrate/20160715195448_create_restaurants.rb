class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.text :description
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state_provence
      t.string :postalcode
      t.string :phone
      t.string :website

      t.timestamps null: false
    end
  end
end
