class Admin::MoviesController < ApplicationController
  before_action :authenticate_admin!
  #before_action :check_admin

  def index
    @movies = Movie.all
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to admin_movies_path, notice: 'Movie successfully created.'
    else
      render :new
    end
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.update(movie_params)
      redirect_to admin_movie_path(@movie), notice: 'Movie successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to admin_movies_path, notice: 'Movie successfully deleted.'
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :genre, :duration, :language, :rating, :release_date)
  end
  def check_admin
    unless current_user.is_admin?
      redirect_to root_path, alert: "You are not authorized to access this page."
    end
  end
end
