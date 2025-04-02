class TicketsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :index, :show]
  before_action :set_ticket, only: [:destroy, :cancel]

  def index
    @tickets = current_user.tickets
  end

  def show
    @ticket = Ticket.find(params[:id])
  end

  def new
    @ticket = Ticket.new
  end

  def update
    @ticket = Ticket.find(params[:id])
    if @ticket.update(ticket_params)
      redirect_to @ticket, notice: "Ticket successfully updated."
    else
      render :edit, alert: "Failed to update ticket."
    end
  end


  def create
    @show = Show.find(params[:ticket] ? params[:ticket][:show_id] : params[:show_id])  # Admin uses params[:ticket][:show_id], User uses params[:show_id]
    quantity = params[:ticket] ? params[:ticket][:quantity].to_i : params[:quantity].to_i   # Same for quantity field
    user_id = params[:ticket] ? params[:ticket][:user_id] : current_user.id
    user = User.find_by(id: user_id)
    if quantity <= 0
      redirect_to show_path(@show), alert: "Please select a valid quantity."
      return
    end

    Rails.logger.debug "Show: #{@show.inspect}"
    Rails.logger.debug "Quantity: #{quantity}"

    # Check if the movie is released, the show is available, and enough seats are available
    if @show.movie.released? && @show.available? && @show.seats_available >= quantity
      Ticket.transaction do
        quantity.times do
          ticket = @show.tickets.new(user: user, status: 'Booked')

          # Generate unique confirmation number
          begin
            ticket.confirmation_number = SecureRandom.hex(10)
          end while Ticket.exists?(confirmation_number: ticket.confirmation_number)

          if ticket.save
            Rails.logger.debug "Ticket saved: #{ticket.inspect}"
          else
            Rails.logger.debug "Ticket failed to save: #{ticket.errors.full_messages}"
          end
        end

        # Deduct seats from the show
        @show.update!(seats_available: @show.seats_available - quantity)
      end

      redirect_to show_path(@show), notice: "#{quantity} ticket(s) purchased successfully!"
    else
      redirect_to show_path(@show), alert: "Not enough tickets available."
    end
  end

  def edit
    @ticket = Ticket.find(params[:id])
  end

  def destroy
    show = @ticket.show

    # Update ticket status to 'Cancelled' instead of destroying it
    if @ticket.update(status: 'Cancelled')
      # Update available seats in the show
      show.update(seats_available: show.seats_available + 1)

      flash[:notice] = "Ticket canceled successfully."
    else
      flash[:alert] = "Failed to cancel ticket."
    end

    # Redirect based on the user type (Admin or regular user)
    if current_user&.username == "Admin"
      redirect_to admin_dashboard_path
    else
      redirect_to tickets_user_path(current_user)
    end
  end
  def cancel
    @ticket = Ticket.find(params[:id])
    show = @ticket.show  # Get the associated show

    Ticket.transaction do
      if @ticket.update(status: 'Cancelled')
        # Increase available seats
        show.increment!(:seats_available)

        flash[:notice] = "Ticket was successfully canceled."
      else
        flash[:alert] = "Failed to cancel the ticket."
        raise ActiveRecord::Rollback  # Rollback if update fails
      end
    end

    # Redirect based on user role
    if current_user&.username == "Admin"
      redirect_to admin_dashboard_path
    else
      redirect_to tickets_user_path(current_user)
    end
  end

  def set_ticket
    @ticket = Ticket.find(params[:id])
  end

  private

  def ticket_params
    params.require(:ticket).permit(:show_id, :user_id)
  end
end
