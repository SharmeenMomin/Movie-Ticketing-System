class ScreensController < ApplicationController
  before_action :set_screen, only: [:show, :edit, :update, :destroy]

  def index
    @screens = Screen.all
  end

  def new
    @screen = Screen.new
  end

  def create
    @screen = Screen.new(screen_params)
    if @screen.save
      redirect_to screens_path, notice: 'Screen was successfully created.'
    else
      render :new
    end
  end

  def show
  end
  

  def edit
  end

  def update
    if @screen.update(screen_params)
      redirect_to screens_path, notice: 'Screen was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @screen.destroy
    redirect_to screens_path, notice: 'Screen was successfully deleted.'
  end

  private

  def set_screen
    @screen = Screen.find(params[:id])
  end

  def screen_params
    params.require(:screen).permit(:name, :capacity, :location)
  end  
end
