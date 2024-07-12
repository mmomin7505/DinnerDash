module Admin
class DashboardsController < ApplicationController
  before_action :authorize_admin
end
end