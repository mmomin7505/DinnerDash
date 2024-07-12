class ApplicationController < ActionController::Base
    before_action :set_categories

  protected
  
  def authorize_admin
   redirect_to root_path, alert:"You are not authorize to access this page." unless current_user&.admin?
  end

  def set_categories
    @categories = Category.all
  end
end
