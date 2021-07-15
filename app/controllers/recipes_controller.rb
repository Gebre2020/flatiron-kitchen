class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update]
  def new
    @ingredients = Ingredient.all
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params(params))
    if @recipe.save
      redirect_to recipe_path(@recipe)
    else
      render :new
    end
  end

  def show
  end

  def edit
    @ingredients = Ingredient.all
  end

  def update
    @recipe.update(recipe_params(params))
    if @recipe.save
      @recipe.ingredients.clear if !params[:recipe][:ingredient_ids]
      @recipe.save
      redirect_to @recipe
    else
      render :edit
    end
  end

  private
  def recipe_params(params)
    params.require(:recipe).permit(:name, ingredient_ids: [])
  end

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end
end
