require 'json'
require 'open-uri'

# # ------------ INGREDIENTS ------------ #
# # Destroy previous entries
# Ingredient.destroy_all
# puts 'All ingredient entries deleted'

# # Fetch cocktail API
# url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
# data = JSON.parse(open(url).read)

# ingredients = data['drinks']

# ingredients.each do |drink|
#   name = drink.values.join.downcase
#   Ingredient.create!(name: name)
# end
# puts '100 ingredients added'
# # ------------------------------------- #

# ------------ COCKTAILS ------------ #
# # Destroy previous entries
# Cocktail.destroy_all
# puts 'All cocktail entries deleted'

# Fetch cocktail API
url = 'https://www.thecocktaildb.com/api/json/v1/1/random.php'

50.times do
  data = JSON.parse(open(url).read)
  cocktail_data = data['drinks'].first

  Cocktail.create(
    cocktail_API_id: cocktail_data['idDrink'],
    name: cocktail_data['strDrink'],
    recipe: cocktail_data['strInstructions'],
    image_url: cocktail_data['strDrinkThumb']
  )
  puts 'new cocktail created'
end
puts '25 cocktails added'
# ------------------------------------- #

# --------------- DOSES --------------- #
# # Destroy previous entries
# Dose.destroy_all
# puts 'All previous doses destroyed'

cocktails = Cocktail.all
cocktails.each do |cocktail|
  api_id = cocktail.cocktail_API_id
  url = "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=#{api_id}"
  data = JSON.parse(open(url).read)

  counter = 1
  ingredient = data['drinks'].first["strIngredient#{counter}"]

  until ingredient.nil?
    ingredient = data['drinks'].first["strIngredient#{counter}"]
    description = data['drinks'].first["strMeasure#{counter}"]

    unless ingredient.nil? || description.nil?
      ingredient = ingredient.downcase
      dose = Dose.new(description: description)
      dose.ingredient = Ingredient.where(name: ingredient).first || Ingredient.create(name: ingredient)
      dose.cocktail = cocktail
      dose.save

      puts 'new dose added'
    end

    counter += 1
  end
end
puts 'All doses added'
# ------------------------------------- #
