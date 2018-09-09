class AddHexToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :code, :string
  end
end
