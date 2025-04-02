# class UsersController < ApplicationController
#   before_action :authenticate_admin!, only: [:admin_dashboard, :manage_users, :manage_movies, :manage_shows, :manage_tickets, :create_user, :create_movie, :create_show, :create_ticket]
#   before_action :set_user, only: [:edit, :update, :show, :destroy]
#   before_action :set_movie, only: [:manage_movies, :create_show, :edit_show]
#   before_action :set_show, only: [:manage_shows, :create_ticket]
#
#   # Admin Dashboard: Admin can view all movies, users, shows, and tickets
#   def admin_dashboard
#     @users = User.all
#     @movies = Movie.all
#     @shows = Show.all
#     @tickets = Ticket.all
#   end
#
#   # Admin: View all users
#   def manage_users
#     @users = User.all
#   end
#
#   # Admin: View all movies
#   def manage_movies
#     @movies = Movie.all
#   end
#
#   # Admin: View all shows for a specific movie
#   def manage_shows
#     @movie = Movie.find(params[:movie_id])
#     @shows = @movie.shows
#   end
#
#   # Admin: Create a new user
#   def create_user
#     @user = User.new(user_params)
#     if @user.save
#       redirect_to manage_users_path, notice: 'User created successfully.'
#     else
#       render :manage_users, alert: 'Failed to create user.'
#     end
#   end
#
#   # Admin: Create a new movie
#   def create_movie
#     @movie = Movie.new(movie_params)
#     if @movie.save
#       redirect_to manage_movies_path, notice: 'Movie created successfully.'
#     else
#       render :manage_movies, alert: 'Failed to create movie.'
#     end
#   end
#
#   # Admin: Create a new show for a movie
#   def create_show
#     @show = @movie.shows.new(show_params)
#     if @show.save
#       redirect_to manage_shows_path(movie_id: @movie.id), notice: 'Show created successfully.'
#     else
#       render :manage_movies, alert: 'Failed to create show.'
#     end
#   end
#
#   # Admin: Edit own profile (ID, username, password cannot be updated)
#   def edit
#     @user = current_user
#   end
#
#   # Admin: Update profile (Cannot update ID, username, or password)
#   def update
#     @user = current_user
#     if @user.update_without_password(user_params)
#       redirect_to admin_dashboard_path, notice: 'Profile updated successfully.'
#     else
#       render :edit, alert: 'Failed to update profile.'
#     end
#   end
#
#   # Admin: Edit or Delete Movie
#   def edit_movie
#     @movie = Movie.find(params[:id])
#   end
#
#   def update_movie
#     @movie = Movie.find(params[:id])
#     if @movie.update(movie_params)
#       redirect_to manage_movies_path, notice: 'Movie updated successfully.'
#     else
#       render :edit_movie, alert: 'Failed to update movie.'
#     end
#   end
#
#   def destroy_movie
#     @movie = Movie.find(params[:id])
#     if @movie.destroy
#       redirect_to manage_movies_path, notice: 'Movie deleted successfully.'
#     else
#       redirect_to manage_movies_path, alert: 'Failed to delete movie.'
#     end
#   end
#
#   # Admin: Edit or Delete Show
#   def edit_show
#     @show = Show.find(params[:id])
#   end
#
#   def update_show
#     @show = Show.find(params[:id])
#     if @show.update(show_params)
#       redirect_to manage_shows_path(movie_id: @show.movie.id), notice: 'Show updated successfully.'
#     else
#       render :edit_show, alert: 'Failed to update show.'
#     end
#   end
#
#   def destroy_show
#     @show = Show.find(params[:id])
#     if @show.destroy
#       redirect_to manage_shows_path(movie_id: @show.movie.id), notice: 'Show deleted successfully.'
#     else
#       redirect_to manage_shows_path(movie_id: @show.movie.id), alert: 'Failed to delete show.'
#     end
#   end
#
#   # Admin: Create/View/Edit/Delete Tickets
#   def manage_tickets
#     @tickets = Ticket.all
#   end
#
#   def destroy_ticket
#     @ticket = Ticket.find(params[:id])
#     if @ticket.destroy
#       redirect_to manage_tickets_path, notice: 'Ticket deleted successfully.'
#     else
#       redirect_to manage_tickets_path, alert: 'Failed to delete ticket.'
#     end
#   end
#
#   private
#
#   def authenticate_admin!
#     redirect_to root_path, alert: 'Access Denied: Admins Only' unless current_user.admin?
#   end
#
#   # Set Movie for show creation
#   def set_movie
#     @movie = Movie.find(params[:movie_id]) if params[:movie_id]
#   end
#
#   # Set Show for ticket management
#   def set_show
#     @show = Show.find(params[:show_id]) if params[:show_id]
#   end
#
#   # Set user for editing profile
#   def set_user
#     @user = User.find(params[:id])
#   end
#
#   # Strong Parameters for user profile
#   def user_params
#     params.require(:user).permit(:name, :email, :address, :phone_number, :password, :password_confirmation)
#   end
#
#   # Strong Parameters for movie
#   def movie_params
#     params.require(:movie).permit(:title, :genre, :duration, :language, :rating, :release_date)
#   end
#
#   # Strong Parameters for show
#   def show_params
#     params.require(:show).permit(:date, :time, :seats_available, :ticket_price, :movie_id)
#   end
# end

class Admin::UsersController < Admin::ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, notice: 'User successfully deleted.'
  end
end
