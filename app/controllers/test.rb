require 'json'
require 'open-uri'

url = "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=12322"
# This cocktail has 5 ingredients
data = JSON.parse(open(url).read)

# p data['drinks'].first['strIngredient3'].downcase
# p data['drinks'].first['strMeasure2'].downcase

# counter = 1
# ingredient = data['drinks'].first["strIngredient#{counter}"]

# until ingredient.nil?
#   dose = Dose.new(description: data['drinks'].first["strMeasure#{counter}"])
#   dose.ingredient = Ingredient.where(name: ingredient.downcase)
#   dose.cocktail = cocktail
#   dose.save

#   counter += 1
# end

counter = 1
ingredient = data['drinks'].first["strIngredient#{counter}"]

until ingredient.nil?
  ingredient = data['drinks'].first["strIngredient#{counter}"]
  description = data['drinks'].first["strMeasure#{counter}"]
  unless ingredient.nil? || description.nil?
    p ingredient.downcase + '   ' + data['drinks'].first["strMeasure#{counter}"]
  end
  counter += 1
end
