# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# require 'json'
# require 'open-uri'

# url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
# ingredients_list = JSON.parse(open(url).read)
# ingredients_list["drinks"].map! do |item|
#   item["strIngredient1"]
# end
# ingredients_list.sort!
require 'json'
require 'open-uri'

puts 'Cleaning database...'
Cocktail.destroy_all
Ingredient.destroy_all

puts 'Creating Cocktails...'
cocktails = [{ name: 'Mojito' }, { name: 'Bloody Mary' }, { name: 'Sex on the Beach'}, { name: 'Margarita'}, { name: 'Pina Colada'}]
cocktail_objects = []
cocktails.each do |cocktail|
  cocktail_objects << Cocktail.create!(cocktail)
end

puts 'Creating Ingredients...'
ingredients = [{ name: 'Mint' }, { name: 'Vodka' }, { name: 'Rhum'}, { name: 'Tequila'}, { name: 'Orange Juice'}, { name: 'Tomato Juice'}]
ingredient_objects = []
ingredients.each do |ingredient|
  ingredient_objects << Ingredient.create!(ingredient)
end

puts 'Creating Doses...'
doses = [
  { description: '6 leaves', cocktail: cocktail_objects[0], ingredient: ingredient_objects[0] },
  { description: '1.5 oz', cocktail: cocktail_objects[0], ingredient: ingredient_objects[2] },
  { description: '4.5 cl', cocktail: cocktail_objects[1], ingredient: ingredient_objects[1] },
  { description: '9 cl', cocktail: cocktail_objects[1], ingredient: ingredient_objects[5] },
  { description: '1.33 oz', cocktail: cocktail_objects[2], ingredient: ingredient_objects[1] },
  { description: '1.33 oz', cocktail: cocktail_objects[2], ingredient: ingredient_objects[4] },
  { description: '2 cl', cocktail: cocktail_objects[3], ingredient: ingredient_objects[3] }
]
doses.each do |dose|
  Dose.create!(
    description: dose[:description],
    cocktail: dose[:cocktail],
    ingredient: dose[:ingredient]
  )
end

puts 'creating Ingredient lists...'
url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
ingredients_in_use = ingredients.map { |hash| hash[:name] }
ingredients_list = JSON.parse(open(url).read)
ingredients_list["drinks"].map! do |item|
  item["strIngredient1"]
end
ingredients_list["drinks"].each do |name|
  Ingredient.create!(name: name) unless ingredients_in_use.include?(name)
end
puts 'Finished!'
