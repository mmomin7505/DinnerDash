class ItemsController < ApplicationController
  def index
    @item = Item.all
    if params[:search]
      @item = Item.where("LOWER(title) LIKE ?", "%#{params[(:search)].downcase}%")
    end
  end
end
