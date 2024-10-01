require 'rails_helper'

describe Recipe do
  describe '.search' do
    it 'returns recipes with a matching title' do
      ingredients = [
        Ingredients.create(name: 'spaghetti'),
        Ingredients.create(name: 'egg')
      ]
      recipe = Recipe.create(title: 'Pasta Carbonara', ingredients: ingredients)

      expect(Recipe.search('Pasta')).to include(recipe)
      expect(Recipe.search('egg')).to   include(recipe)
    end
  end

  describe '.with_ingredients' do
    it 'returns recipes with the given ingredient' do
      ingredients = [
        Ingredients.create(name: 'spaghetti'),
        Ingredients.create(name: 'egg')
      ]
      recipe = Recipe.create(title: 'Spaghetti Carbonara', ingredients: ingredients)
      expect(Recipe.with_ingredients('spaghetti')).to include(recipe)
    end
  end

  describe '.create_from_json!' do
    it 'creates a recipe and its ingredients' do
      recipe_json = {
        'title'       => 'Pasta Carbonara',
        'ingredients' => ['spaghetti', 'egg']
      }

      recipe = Recipe.create_from_json!(recipe_json)

      expect(recipe).to be_persisted
      expect(recipe.ingredients.count).to eq(2)
    end
  end
end
