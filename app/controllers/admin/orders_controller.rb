class Admin::OrdersController < ApplicationController
    def index
        @status = Order.pluck(:status).uniq
        if params[:status].present?
            @orders = Order.where(status: params[:status])
          else
            @orders = Order.all
          end
    end

    def show
        @order = Order.find(params[:id])
        @order_items = @order.order_items.includes(:item)
        @user = @order.user
    end

    def paid_order
        @order = Order.find(params[:id])
        @order.update_attribute(:status,"paid")
        @order.update_attribute(:completed_at, Time.current)
        redirect_to admin_orders_path
    end

    def complete_order
        @order = Order.find(params[:id]) 
        @order.update_attribute(:status,"completed")
        @order.update_attribute(:completed_at, Time.current)
        redirect_to admin_orders_path
    end

    def cancel_order
        @order = Order.find(params[:id]) 
        @order.update_attribute(:status,"canceled")
        @order.update_attribute(:canceled_at, Time.current)
        redirect_to admin_orders_path
    end

end
