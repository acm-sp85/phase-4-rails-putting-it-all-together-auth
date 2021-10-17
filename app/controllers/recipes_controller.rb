class RecipesController < ApplicationController
    def index
        user = User.find_by(id: session[:user_id])
        if user
            render json: user.recipes, status: :created
        else
          render json: {errors: ["User is not logged in"]}, status: :unauthorized
        end
    end
    def create
        user = User.find_by(id: session[:user_id])
        if user
           recipe = user.recipes.create(recipe_params)
           if recipe.valid?
            render json: recipe, status: :created
           else
            render json: {errors: ["Unable to create recipe"]}, status: :unprocessable_entity

           end
        else
          render json: {errors: ["User is not logged in"]}, status: :unauthorized
        end
    end

    private
    def recipe_params
        params.permit(:title, :instructions, :minutes_to_complete, :user_id)
    end
end
