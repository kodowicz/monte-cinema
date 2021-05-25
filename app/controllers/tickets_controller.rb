# frozen_string_literal: true

class TicketsController < ApplicationController
  before_action :set_ticket, only: %i[show update destroy]

  # GET /tickets
  def index
    @tickets = TicketDesk.find(params[:ticket_desk_id]).reservations.find(params[:reservation_id]).tickets
    # @tickets = Ticket.all.map do |res|
    #   render_ticket(res)
    # end
    render json: @tickets
  end

  # GET /tickets/:ticket_id
  def show
    render json: render_ticket(@ticket)
  end

  # POST /tickets/
  def create
    @ticket = Ticket.create(ticket_params)

    if @ticket.save
      render json: @ticket, status: :created
    else
      render json: @ticket.errors, status: :unprocessable_entity
    end
  end

  # PUT /tickets/:ticket_id
  def update
    if @ticket.update!(ticket_params)
      render json: @ticket, status: :ok
    else
      render json: @ticket.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tickets/:ticket_id
  def destroy
    if @ticket.destroy!
      render json: @ticket, status: :ok
    else
      render json: @ticket.errors, status: :unprocessable_entity
    end
  end

  private

  def render_ticket(ticket)
    {
      id: ticket.id,
      movie_title: ticket.movie_title,
      seat: ticket.seat,
      type: ticket.type,
      price: ticket.price
    }
  end

  def set_ticket
    @ticket = Ticket.find(params[:id])
  end

  def ticket_params
    params.require(:ticket).permit(:movie_title, :seat, :type, :price)
  end
end