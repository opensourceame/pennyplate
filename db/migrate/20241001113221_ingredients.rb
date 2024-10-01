# frozen_string_literal: true
#
class Ingredients < ActiveRecord::Migration[7.1]
  def change
    create_table :ingredients do |t|
      t.timestamps
      t.string :name
      t.references :recipe, null: false, foreign_key: true
    end
  end
end
