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
    joins(:ingredients).where('ingredients.name ILIKE ?', "%#{term}%")
  }

  def self.search(term)
    Recipe.includes(:ingredients).where('title ILIKE ?', "%#{term}%") + Recipe.with_ingredients(term)
  end

  def self.search_including_any_terms(terms)
    terms.map do |term|
      Recipe.with_ingredients(term)
    end.flatten
  end

  def self.search_including_all_terms(terms)
    results = Recipe.joins(:ingredients).distinct

    terms.each do |term|
      ids = Recipe.with_ingredients(term).pluck(:id)
      results = results.where(id: ids)
    end

    results
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

  def sanitized_image_url
    URI.decode_uri_component(image_url.split('=').last)
  end
end
