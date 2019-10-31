class AddColumnToCocktails < ActiveRecord::Migration[5.2]
  def change
    add_column :cocktails, :cocktail_API_id, :integer
  end
end
