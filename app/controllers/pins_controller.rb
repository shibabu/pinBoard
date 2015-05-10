class PinsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_pin, except: [:new, :create, :index]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @pins=Pin.all.order 'created_at DESC'
  end

  def show
  end

  def new
    @pin=current_user.pins.build
  end

  def create
    @pin=current_user.pins.build pin_params
    if @pin.save
      redirect_to @pin, notice: 'Pin created'
    else
      flash.now[:alert]='Could not create pin. '
      render :new
    end
  end

  def vote
    @pin.upvote_by current_user
    redirect_to :back
  end

  def edit
  end

  def update
    if @pin.update pin_params
      redirect_to @pin, notice: 'Pin updated'
    else
      flash.now[:alert]='Could not update Pin, please check the errors below:'
      render :edit
    end
  end

  def destroy
    if @pin.destroy
      redirect_to root_path, notice: 'Pin deleted'
    else
      redirect_to :back, alert: 'Could not delete pin. '
    end
  end

  private
  def set_pin
    @pin=Pin.find params[:id]
  end

  def pin_params
    params.require(:pin).permit :title, :description, :user_id, :image
  end

  def require_same_user
    unless current_user==@pin.user
      redirect_to root_path, alert: 'You cannot modify other users Pins'
    end
  end
end
