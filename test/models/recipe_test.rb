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
require "test_helper"

class RecipeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
