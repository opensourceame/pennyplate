# frozen_string_literal: true

# == Schema Information
#
# Table name: recipes
#
#  id         :bigint           not null, primary key
#  title      :string
#  cook_time  :integer
#  prep_time  :integer
#  image      :string
#  author     :string
#  ratings    :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Recipe < ApplicationRecord
  has_many :ingredients, dependent: :destroy, class_name: 'Ingredients'

  scope :with_ingredients, ->(term) {
    joins(:ingredients).where('ingredients.name LIKE ?', "%#{term}%")
  }

  def self.search(term)
    Recipe.where('title LIKE ?', "%#{term}%") + Recipe.with_ingredients(term)
  end

  def self.create_from_json!(recipe_json)
    recipe = Recipe.create!(
      title:        recipe_json['title'],
      cook_time:    recipe_json['cook_time'],
      prep_time:    recipe_json['prep_time'],
      image_url:    recipe_json['image'],
      author:       recipe_json['author'],
      ratings:      recipe_json['ratings']
    )

    recipe_json['ingredients'].each do |ingredient|
      recipe.ingredients.create!(name: ingredient)
    end

    recipe
  end
end
