class Dashboard::ItemsController < ApplicationController

  before_action :authenticate_user!
  before_action :load_box

  def index
    @items = @box.items
  end

  def new
    @item = @box.items.new
  end

  def create
    item = @box.items.new(create_item_params)
    if not item.save
      flash[:alert] = "Error adding new item into #{box.label}"
    end
    redirect_to dashboard_box_items_path(@box)
  end

  def edit
    @item = @box.items.find_by(id: params[:id])
  end

  def update
    item = @box.items.find_by(id: params[:id])
    item.amount = update_item_params[:amount]
    flash[:error] = "There is an error updating the item" unless item.save
  end

  def destroy
    item = @box.items.find_by(id: params[:id])
    @error = item.nil?
    if item
      item.destroy
    else
      flash[:alert] = "Item doesn't exist."
    end
  end

  private
    def create_item_params
      params.require(:item).permit(:label, :expire_date, :amount)
    end
    def update_item_params
      params.require(:item).permit(:amount)
    end
    def load_box
      @box = current_user.boxes.find_by(id: params[:box_id])
    end
  
end
