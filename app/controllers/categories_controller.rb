class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

     def index
          @categories = Category.order(:label)
     end

     def show
          @categories = Category.order(:label)
          @category = Category.find(params[:id])
     end

     def new
          @category = Category.new
     end

     def edit; end

     def create
          @category = Category.create(category_params)
          if @category.id != nil
              redirect_to categories_path
          else
              render "new"
          end
     end

     def update
          @category.update(category_params)
     end

     def destroy
          @category.destroy
     end

     private
     def set_category
           @category = Category.find(params[:id])
     end

     def category_params
           params.require(:category).permit(:label)
     end
end
