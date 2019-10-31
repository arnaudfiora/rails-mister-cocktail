class ChangeDescriptionNameInCocktails < ActiveRecord::Migration[5.2]
  def change
    rename_column :cocktails, :description, :recipe
  end
end
