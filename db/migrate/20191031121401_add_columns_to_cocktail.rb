class AddColumnsToCocktail < ActiveRecord::Migration[5.2]
  def change
    add_column :cocktails, :description, :text
    add_column :cocktails, :image_url, :string
  end
end
