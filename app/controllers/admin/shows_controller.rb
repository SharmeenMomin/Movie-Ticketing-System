class Admin::ShowsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @movie = Movie.find(params[:movie_id])
    @shows = @movie.shows
  end

  def new
    @movie = Movie.find(params[:movie_id])
    @show = @movie.shows.build
  end

  def create
    @movie = Movie.find(params[:movie_id])
    @show = @movie.shows.build(show_params)
    if @show.save
      redirect_to admin_movie_shows_path(@movie), notice: 'Show successfully created.'
    else
      render :new
    end
  end

  def edit
    @show = Show.find(params[:id])
  end

  def update
    @show = Show.find(params[:id])
    if @show.update(show_params)
      redirect_to admin_movie_show_path(@show.movie, @show), notice: 'Show successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @show = Show.find(params[:id])
    @show.destroy
    redirect_to admin_movie_shows_path(@show.movie), notice: 'Show successfully deleted.'
  end

  private

  def show_params
    params.require(:show).permit(:date, :time, :seats_available, :ticket_price , :confirmation_number)
  end
end
