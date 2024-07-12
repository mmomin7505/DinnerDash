class Admin::CategoriesController < ApplicationController
    def index
        @categories = Category.all
    end

    def new
        @category = Category.new
    end

    def create
        @category = Category.new(category_params)
        if @category.save
          flash[:success] = "category successfully Added"
          redirect_to  admin_categories_path
        else
          flash[:error] = "Something went wrong"
          render 'new'
        end
    end

    def edit
        @category = Category.find(params[:id])
    end

    def update
        @category = Category.find(params[:id])
        if @category.update(category_params)
            redirect_to admin_categories_path, notice: 'category was successfully updated.'
        else
            render :edit
        end
    end

   def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to admin_categories_path
   end

   def remove_item 
    @category = Category.find(params[:id])
    item = Item.find(params[:item_id]) 
    @category.items.delete(item) 
    redirect_to edit_admin_category_path(@category) 
   end

   private

    def category_params
        params.require(:category).permit(:name,:image)
    end

end
