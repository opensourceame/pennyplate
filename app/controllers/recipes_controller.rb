class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[ show edit update destroy ]

  # GET /recipes or /recipes.json
  def index
    # show some recipes on load
    if params[:search].blank?
      @recipes = Recipe.all.limit(10)
    else
      search_recipes
    end
  end

  def search
    search_recipes

    render 'search', layout: nil
  end

  # GET /recipes/1 or /recipes/1.json
  def show
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
  end

  # GET /recipes/1/edit
  def edit
  end

  # POST /recipes or /recipes.json
  def create
    @recipe = Recipe.new(recipe_params)

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to @recipe, notice: "Recipe was successfully created." }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipes/1 or /recipes/1.json
  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to @recipe, notice: "Recipe was successfully updated." }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1 or /recipes/1.json
  def destroy
    @recipe.destroy!

    respond_to do |format|
      format.html { redirect_to recipes_path, status: :see_other, notice: "Recipe was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def recipe_params
    params.require(:recipe).permit(:title, :cook_time, :prep_time, :image, :author, :ratings)
  end

  def search_recipes
    terms   = params[:search].split
    recipes = []

    terms.each do |term|
      # TODO: make a model function that handles multiple terms instead of doing it here
      recipes << Recipe.search(term)
    end

    return @recipes = recipes.flatten! if !params[:use_all_ingredients]
    return @recipes = recipes.first if recipes.length == 1

    # find the intersection of recipes that have all the ingredients
    # TODO: make this more efficient
    m = recipes.first.map(&:id)

    recipes[1..].each do |recipe|
      m = m & recipe.map(&:id)
    end

    @recipes = Recipe.where(id: m)
  end
end
