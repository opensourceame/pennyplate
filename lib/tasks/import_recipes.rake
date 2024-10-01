# frozen_string_literal: true

task import_recipes: :environment do
  filename = ENV.fetch("FILENAME", "db/seeds/recipes-en.json")
  recipes = JSON.parse(File.read(filename))

  recipes.each do |recipe|
    Recipe.create_from_json!(recipe)
  end
end
