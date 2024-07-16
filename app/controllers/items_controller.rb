class ItemsController < ApplicationController
  def index
    if params[:search]
      @item = Item.where("LOWER(title) LIKE ?", "%#{params[(:search)].downcase}%")
    elsif params[:category_id]
      @category = Category.find(params[:category_id])
      @item =  @category.items
    else
      @item = Item.all
    end
  end
end
