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
    item = @box.items.new(item_params)
    unless item.save
      flash[:alert] = "Error adding new item into #{box.label}"
    end
    redirect_to dashboard_box_items_path(@box)
  end

  def edit
    @item = @box.items.find_by(id: params[:id])
    mode = params[:mode]
    render "dashboard/items/edit" if mode == 'compact'
    render "dashboard/items/edit_full" if mode == 'full'
  end

  def update
    item = @box.items.find_by(id: params[:id])
    success = item.update(item_params)
    unless success
      flash[:error] = "There is an error updating the item"
    end
    @redirect_path = params[:dest]
  end

  def destroy
    item = @box.items.find_by(id: params[:id])
    @error = item.nil?
    if item
      item.destroy
    else
      flash[:alert] = "Item doesn't exist."
    end
    @redirect_path = params[:dest]
  end

  private
    def item_params
      params.require(:item).permit(:label, :expire_date, :amount)
    end
    def load_box
      @box = current_user.boxes.find_by(id: params[:box_id])
    end
  
end
