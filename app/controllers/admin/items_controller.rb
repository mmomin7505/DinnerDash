class Admin::ItemsController < ApplicationController
    before_action :authorize_admin
    def index
        @items = Item.all
    end

    def new
        @item = Item.new
    end

    def edit
        @item = Item.find(params[:id])
    end

   def update
    @item = Item.find(params[:id])
       if @item.update(item_params)
        redirect_to admin_items_path, notice: 'Item was successfully updated.'
      else
        render :edit
      end
   end
   


    def create
        @item = Item.new(item_params)
        if @item.save
          flash[:success] = "Item successfully Added"
          redirect_to  admin_items_path
        else
          flash[:error] = "Something went wrong"
          render 'new'
        end
    end

    def destroy
        @item = Item.find(params[:id])
        @item.destroy
        redirect_to admin_items_path
    end
    
    private

    def item_params
        params.require(:item).permit(:title, :description, :price,:quantity,:category_ids,:image)
    end
    
    
end
