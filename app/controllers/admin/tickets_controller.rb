class Admin::TicketsController < Admin::ApplicationController
  before_action :authenticate_admin!

  def index
    @tickets = Ticket.all
  end

  def show
    @ticket = Ticket.find(params[:id])
  end

  def destroy
    @ticket = Ticket.find(params[:id])
    @ticket.destroy
    redirect_to admin_tickets_path, notice: 'Ticket successfully deleted.'
  end
end
