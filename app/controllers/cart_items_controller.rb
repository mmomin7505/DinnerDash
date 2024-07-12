class CartItemsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :update

  def create
    if user_signed_in?
      @cart = current_user.cart || current_user.create_cart
      @cart_item = @cart.cart_items.find_or_initialize_by(item_id: cart_item_params[:item_id])
      @cart_item.quantity ||= 0
      requested_quantity = @cart_item.quantity + cart_item_params[:quantity].to_i
      item = Item.find(cart_item_params[:item_id])

      if requested_quantity > item.quantity
        redirect_back fallback_location: items_path, alert: "Unsufficient Quantity, Available quantity for this item is #{item.quantity}" 
      elsif @cart_item.update(quantity: requested_quantity)
        redirect_back fallback_location: items_path, notice: 'Item added to cart successfully.'
      else
        redirect_back fallback_location: root_path, alert: 'Failed to add item to cart.'
      end
    else
      add_to_session_cart
    end
  end

  def destroy
    if user_signed_in?
      @cart_item = CartItem.find(params[:id])
      @cart_item.destroy
      redirect_to cart_path, notice: 'Item removed from cart successfully.'
    else
      remove_from_session_cart
    end
  end

  def checkout
    if user_signed_in?
      @order = current_user.orders.create(
        amount: calculate_total_price,
        status: 'ordered',
        created_at: Time.current
      )

      current_user.cart.cart_items.each do |cart_item|
        @order.order_items.create(
          item: cart_item.item,
          quantity: cart_item.quantity,
          amount: cart_item.quantity * cart_item.item.price
        )
      end

      current_user.cart.cart_items.destroy_all
      redirect_to orders_path, notice: 'Your order has been placed successfully.'
    else
      redirect_to new_user_session_path, alert: "You need to Sign In First."
    end
  end

  def update
    cart_item = CartItem.find(params[:id])
    item = Item.find(cart_item.item_id)
    new_quantity = params[:cart_item][:quantity].to_i

    if new_quantity > item.quantity
      redirect_back fallback_location: cart_path, alert: "Unsufficient Quantity, Available quantity for this item is #{item.quantity}"
    elsif cart_item.update(quantity: new_quantity)
      redirect_to cart_path, notice: 'Cart item updated successfully.'
    else
      redirect_back fallback_location: cart_path, alert: 'Failed to update cart item.'
    end
  end
    
  private
  
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :quantity)
  end

  def add_to_session_cart
    session[:cart] ||= []
    item = session[:cart].find { |i| i['item_id'] == cart_item_params[:item_id].to_i }
    item_record = Item.find(cart_item_params[:item_id])

    if item
      new_quantity = item['quantity'] + cart_item_params[:quantity].to_i
      if new_quantity > item_record.quantity
        redirect_back fallback_location: items_path, alert: "Unsufficient Quantity, Available quantity for this item is #{item_record.quantity}" 
      else
        item['quantity'] += cart_item_params[:quantity].to_i
        redirect_back fallback_location: items_path, notice: 'Item added to cart successfully.'
      end
    else
      if cart_item_params[:quantity].to_i > item_record.quantity
        redirect_back fallback_location: items_path, alert: "Unsufficient Quantity, Available quantity for this item is #{item_record.quantity}" 
      else
        session[:cart] << cart_item_params.to_h
        redirect_back fallback_location: items_path, notice: 'Item added to cart successfully.'
      end
    end
  end

  def remove_from_session_cart
    item_id = params[:id].to_i
    session[:cart].reject! { |item| item['item_id'] == item_id.to_s }
    head :no_content
  end

  def calculate_total_price
    current_user.cart.cart_items.sum { |cart_item| cart_item.item.price * cart_item.quantity }
  end
end
