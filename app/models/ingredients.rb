# frozen_string_literal: true

# == Schema Information
#
# Table name: ingredients
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string
#  recipe_id  :bigint           not null
#
class Ingredients < ApplicationRecord
  belongs_to :recipe
end
