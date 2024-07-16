class OrdersController < ApplicationController
  before_action :custom_authenticate_user!
  def index
    @orders = current_user.orders
  end

  def order_confirmation
  end

end
