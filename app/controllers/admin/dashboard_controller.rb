class Admin::DashboardController < ApplicationController
  def index
    if current_user.username != "Admin"
      redirect_to home_index_path, notice: 'You are not permitted to view this page!'
    end

    @movies = Movie.all
    @shows = Show.all
    @users = User.all
    @screen = Screen.all

    if params[:search].present?
      # Search for tickets based on the movie title
      @tickets = Ticket.joins(show: :movie)
                       .where("movies.title LIKE ?", "%#{params[:search]}%")
                       .includes(:user, :show)
    else
      @tickets = Ticket.all.includes(:user, :show)
    end
  end
end