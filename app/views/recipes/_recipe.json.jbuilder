json.extract! recipe, :id, :title, :cook_time, :prep_time, :image, :author, :ratings, :created_at, :updated_at
json.url recipe_url(recipe, format: :json)
