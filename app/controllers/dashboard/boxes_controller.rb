class Dashboard::BoxesController < ApplicationController

  before_action :authenticate_user!
  before_action :load_current_box, except: [:index, :new, :create]

  def index
    @boxes = current_user.boxes
  end

  def new
    @box = Box.new
  end

  def create
    # create empty model
    access = Access.new
    box = current_user.boxes.new(box_params)
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
      flash[:alert] = "Something went wrong. Contact @hbk"
    end
    redirect_to dashboard_boxes_path
  end

  def edit
  end

  def update
    result = @box.update(box_params)
    unless result
      flash[:alert] = "Cannot update #{@box.label}"
    end
    @redirect_path = params[:dest]
  end

  def destroy
    if box
      box.accesses.destroy_all
      box.items.destroy_all   
      box.destroy
    end
    @redirect_path = params[:dest]
  end

  private
    def box_params
      params.require(:box).permit(:label)
    end
    def load_current_box
      @box = current_user.boxes.find_by(id: params[:id])
    end

end
