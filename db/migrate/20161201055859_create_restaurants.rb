class CreateRestaurants < ActiveRecord::Migration[5.0]
  def change
    create_table :restaurants do |t|
      t.references :post, foreign_key: true
      t.string :name
      t.string :phone
      t.string :address
      t.string :weblink
      t.integer :rating

      t.timestamps
    end
  end
end
