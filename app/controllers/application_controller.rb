class ApplicationController < ActionController::Base
    before_action :set_categories
    helper_method :current_cart
  
   
    def current_cart
      if user_signed_in?
        current_user.cart || current_user.create_cart
      else
        find_or_create_session_cart
      end
    end
  
    private
  
    def find_or_create_session_cart
      if session[:cart_id]
        Cart.find_by(id: session[:cart_id]) || create_session_cart
      else
        create_session_cart
      end
    end
  
    def create_session_cart
      cart = Cart.create
      session[:cart_id] = cart.id
      cart
    end

    def custom_authenticate_user!
      unless user_signed_in?
        flash[:alert] = "You need to sign in to access this page."
        redirect_to new_user_session_path
      end
    end
  
    def authorize_admin
      redirect_to root_path, alert:"You are not authorize to access this page." unless current_user&.admin?
    end

    def set_categories
      @categories = Category.all
    end
end
