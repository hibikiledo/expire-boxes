class Dashboard::AccessesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_and_authorize_resources  

  def index
    @accesses = @box.accesses
  end

  def new
    @access = @box.accesses.new
  end

  def create
    access = @box.accesses.new
    user = User.find_by(email: access_params[:email])
    if user
      access.user = user
      access.role = access_params[:role]
      unless access.save
        flash[:alert] = "Error occurs !"
      end
    else
      flash[:alert] = "Another user with #{access_params[:email]} is not found."
    end
    redirect_to dashboard_box_accesses_path(@box)
  end

  def show

  end

  private
    def access_params
      params.require(:access).permit(:box_id, :role, :email, :role)
    end
    def load_and_authorize_resources
      @box = current_user.boxes.find_by(id: params[:box_id])
      @access = @box.accesses.find_by(user_id: current_user.id)
      unless @access.owner?
        flash[:notice] = "You don't have permission to edit #{@box.label}."
        redirect_to dashboard_path unless @access.owner?
      end
    end

end
