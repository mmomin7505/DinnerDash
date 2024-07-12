class CategoriesController < ApplicationController
    def show
        @Category = Category.find(params[:id])
        @item = @Category.items
      end
end
