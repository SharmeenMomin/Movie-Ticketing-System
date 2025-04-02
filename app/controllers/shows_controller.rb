class ShowsController < ApplicationController
  before_action :set_show, only: %i[ show edit update destroy ]
  before_action :validate_show_params, only: [:create, :update]

  # GET /shows or /shows.json
  def index
    @movie = Movie.find(params[:movie_id])
    @shows = @movie.shows
  end

  # GET /shows/1 or /shows/1.json
  def show
  end

  # GET /shows/new
  def new
    @show = Show.new
  end

  # GET /shows/1/edit
  def edit
    if current_user.username != "Admin"
      redirect_to show_path, notice: 'Access denied!'
    end
  end

  # POST /shows or /shows.json
  def create
    @movie = Movie.find(params[:show][:movie_id])  # Fetch movie by ID
    @show = @movie.shows.build(show_params)        # Associate show with movie
  
    if @show.save
      redirect_to admin_dashboard_path, notice: "Show created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /shows/1 or /shows/1.json
  def update
    respond_to do |format|
      if @show.update(show_params)
        format.html { redirect_to admin_dashboard_path, notice: "Show was successfully updated." }
        format.json { render :show, status: :ok, location: @show }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @show.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shows/1 or /shows/1.json
  def destroy
    @show.destroy!

    if current_user&.username == "Admin"
      redirect_to admin_dashboard_path, notice: "Show was successfully destroyed."
    else
      respond_to do |format|
        format.html { redirect_to shows_path, status: :see_other, notice: "Show was successfully destroyed." }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_show
      @show = Show.find(params[:id])
      #params.require(:show).permit(:available_seats, :ticket_price)
    end

    # Only allow a list of trusted parameters through.
    def show_params
      params.require(:show).permit(:movie_id, :screen_id, :date, :time, :seats_available, :ticket_price)
    end

    def validate_show_params
      if params[:show][:seats_available].to_i < 0 || params[:show][:ticket_price].to_f < 0
        redirect_to new_show_path, alert: "Seats and ticket price cannot be negative."
      end
    end
end
