class Dashboard::BoxesController < ApplicationController

  before_action :authenticate_user!

  def index
    @boxes = current_user.boxes
  end

  def new
    @box = Box.new
  end

  def create
    # create empty model
    access = Access.new
    box = current_user.boxes.new(new_box_params)
    # complete access model
    access.box = box
    access.user = current_user
    access.role = "owner"
    # write to db
    # if box is successfully saved but access fails, remove that box
    begin
      box.save!
      access.save!
    rescue
      box.destroy
      flash[:alert] = "Something went wrong"
    end

    redirect_to dashboard_boxes_path
  end

  def destroy
    box = Box.find_by(id: params[:id])
    @error = box.nil?
    if box
      box.accesses.destroy_all
      box.items.destroy_all   
      box.destroy
    end
  end

  private
    def new_box_params
      params.require(:box).permit(:label)
    end

end
