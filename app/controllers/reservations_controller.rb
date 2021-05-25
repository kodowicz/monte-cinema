# frozen_string_literal: true

class ReservationsController < ApplicationController
  before_action :set_reservation, only: %i[show update destroy]

  # GET /reservations
  def index
    @reservations = TicketDesk.find(params[:ticket_desk_id]).reservations.map do |res|
      render_reservation(res)
    end
    render json: @reservations
  end

  # GET /reservations/:reservation_id
  def show
    render json: render_reservation(@reservation)
  end

  # POST /reservations/
  def create
    @ticket_desk = TicketDesk.find(params[:ticket_desk_id])
    @reservation = @ticket_desk.reservations.create(reservation_params[:paid])
    @ticket = @reservation.tickets.insert_all(reservation_params[:tickets])

    if @reservation.save
      render json: render_reservation(@reservation), status: :created
    else
      render json: @reservation.errors, status: :unprocessable_entity
    end
  end

  # PUT /reservations/:reservation_id
  def update
    if @reservation.update!(reservation_params)
      render json: render_reservation(@reservation), status: :ok
    else
      render json: @reservation.errors, status: :unprocessable_entity
    end
  end

  # DELETE /reservations/:reservation_id
  def destroy
    if @reservation.destroy!
      render json: render_reservation(@reservation), status: :ok
    else
      render json: @reservation.errors, status: :unprocessable_entity
    end
  end

  private

  def render_reservation(reservation)
    {
      id: reservation.id,
      paid: reservation.paid
    }
  end

  def set_reservation
    @ticket_desk = TicketDesk.find(params[:ticket_desk_id])
    @reservation = @ticket_desk.reservation.find(params[:id])
  end

  def reservation_params
    params.require(:reservation).permit(:paid, :tickets)
  end
end
