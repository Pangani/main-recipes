class RecipesController < ApplicationController
    before_action :set_recipe, only: [:show, :edit, :update]

    def index
        @recipes = Recipe.paginate(page: params[:page], per_page: 5)
    end

    def new
        @recipe = Recipe.new
    end
    
    def create
        @recipe = Recipe.new(recipe_params)
        @recipe.chef = current_chef
        if @recipe.save
            flash[:success] = "Recipe was created successfully"
            redirect_to recipe_path(@recipe)
        else
            render 'new'
        end     
    end
    
    def show
    end
    
    def edit
    end

    def update
        if @recipe.update(recipe_params)
            flash[:success] = "Recipe was updated successfully!"
            redirect_to recipe_path(@recipe)
        else
            render 'edit'
        end
        
    end

    def destroy
        @recipe = Recipe.find(params[:id]).destroy
        flash[:success] = "Recipe deleted successfully"
        redirect_to recipes_path
    end
# ------------------------------------------------------------------------
    private
    def recipe_params
        params.require(:recipe).permit(:name, :description)
    end

    def set_recipe
        @recipe= Recipe.find(params[:id])
    end
    
    
end
