class Dashboard::DashboardController < ApplicationController

  before_action :authenticate_user!

  def home
    @boxes = current_user.boxes

    # @items = current_user.boxes.first.items.where("expire_date > #{5.days.ago.strftime("%Y-%m-%d")}").order(expire_date: :desc)
  end

end
