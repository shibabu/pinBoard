class PinsController < ApplicationController
  before_action :set_pin, except: [:new, :create, :index]

  def index
    @pins=Pin.all.order 'created_at DESC'
  end

  def show
  end

  def new
    @pin=Pin.new
  end

  def create
    @pin=Pin.new pin_params
    if @pin.save
      redirect_to @pin, notice: 'Pin created'
    else
      flash.now[:alert]='Could not create pin. '
      render :new
    end
  end

  def vote
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
    params.require(:pin).permit :title, :description, :user_id
  end
end
