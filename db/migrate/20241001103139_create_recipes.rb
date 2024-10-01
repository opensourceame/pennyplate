class CreateRecipes < ActiveRecord::Migration[7.1]
  def change
    create_table :recipes do |t|
      t.timestamps

      t.string  :title
      t.integer :cook_time
      t.integer :prep_time
      t.string  :image_url
      t.string  :author
      t.float   :ratings
    end
  end
end
