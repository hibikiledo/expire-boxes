class Dashboard::BoxesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_and_authorize_resources, only: [:edit, :update, :destroy]

  def index
    @boxes = current_user.boxes
  end

  def new
    @box = Box.new
  end

  def create
    # create empty model
    access = Access.new
    @box = current_user.boxes.new(box_params)
    # complete access model
    access.box = @box
    access.user = current_user
    access.role = "owner"
    # write to db
    # if box is successfully saved but access fails, remove that box
    begin
      @box.save!
      access.save!
      redirect_to dashboard_boxes_path
    rescue
      flash.now[:alert] = @box.errors.full_messages
      render :new
    end
  end

  def edit
  end

  def update
    if @access.owner?
      result = @box.update(box_params)
      unless result
        flash[:alert] = @box.errors.full_messages
      end
    else
      flash[:notice] = "You don't have permission to update #{@box.label} box."
    end
    @redirect_path = params[:dest]
  end

  def destroy
    if @access.owner?
      @box.accesses.destroy_all
      @box.items.destroy_all
      @box.destroy
    else
      flash[:notice] = "You don't have permission to delete #{@box.label} box."
    end
    @redirect_path = params[:dest]
  end

  private
    def box_params
      params.require(:box).permit(:label)
    end
    def load_and_authorize_resources
      @box = current_user.boxes.find_by(id: params[:id])
      @access = @box.accesses.find_by(user_id: current_user.id)
    end

end
