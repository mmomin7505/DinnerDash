class CartsController < ApplicationController
 
  def show
    if user_signed_in?
      @cart = current_user.cart || current_user.create_cart
      @cart_items = @cart.cart_items.includes(:item)
    else
      @cart_items =  session_cart_items 
    end
  end


  def session_cart_items
    session[:cart] ||= []
    item_ids = session[:cart].map { |item| item['item_id'].to_i }
    items = Item.where(id: item_ids).index_by(&:id) 
  
    session[:cart].map do |item|
      OpenStruct.new(
        item: items[item['item_id'].to_i], 
        quantity: item['quantity'].to_i
      )
    end
  end

  def remove_item
    if !user_signed_in?
      session[:cart] ||= []
      session[:cart].reject! { |i| i['item_id'] == params[:id].to_i }
      head :no_content
    end
  end
end
