class Dashboard::ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_box
  #before_action :delay

  def index
    @items = @box.items
  end

  def new
    @item = @box.items.new
    @today = Date.today.strftime('%Y-%m-%d')
  end

  def create
    @item = @box.items.new(item_params)
    if @item.save
      flash.now[:notice] = "#{@item.label} is successfully added."
      redirect_to new_dashboard_box_item_path(@box)
    else
      flash.now[:alert] = @item.errors.full_messages
      render :new
    end
  end

  def edit
    @item = @box.items.find_by(id: params[:id])
    @mode = params[:mode]
  end

  def update
    item = @box.items.find_by(id: params[:id])
    success = item.update(item_params)
    unless success
      flash[:alert] = item.errors.full_messages
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
    def delay
      sleep 1
    end

end
