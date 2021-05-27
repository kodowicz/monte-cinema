# frozen_string_literal: true

class ReservationsController < ApplicationController
  # GET /reservations
  def index
    reservations.map do |res|
      render_reservation(res)
    end
    render json: reservations
  end

  # GET /reservations/:reservation_id
  def show
    render json: render_reservation(@reservation)
  end

  # POST /reservations/
  def create
    if tickets_available?(tickets_params.count)
      reservation = ticket_desk.reservations.new(set_resevation_params)

      tickets_params.each do |params|
        if seat_available?(params[:seat])
          ticket = reservation.tickets.new
          ticket.assign_attributes(params)
        end
      end

      if reservation.tickets.empty?
        reservation.destroy
        render json: { error: 'Chosen seats are not available' }, status: :unprocessable_entity

      elsif reservation.save
        render json: render_reservation(reservation), status: :created

      else
        render json: reservation.errors, status: :unprocessable_entity
      end
    else
      render json: { error: 'The screening does not have enough available seats' }, status: :unprocessable_entity
    end
  end

  # PUT /reservations/:reservation_id
  def update
    if @reservation.update(reservation_params)
      render json: render_reservation(@reservation), status: :ok
    else
      render json: @reservation.errors, status: :unprocessable_entity
    end
  end

  # DELETE /reservations/:reservation_id
  def destroy
    if @reservation.destroy
      render json: render_reservation(@reservation), status: :ok
    else
      render json: @reservation.errors, status: :unprocessable_entity
    end
  end

  private

  def tickets_available?(number)
    hall = screening.cinema_hall
    capacity = hall.capacity

    reserved_seats = screening.reservations.map do |res|
      res.tickets.count
    end.sum

    reserved_seats + number <= capacity
  end

  def seat_available?(check_seat)
    screening.reservations.map do |res|
      res.tickets.map do |ticket|
        ticket.seat != check_seat
      end.all?
    end.all?
  end

  def render_reservation(reservation)
    {
      id: reservation.id,
      paid: reservation.paid
    }
  end

  def ticket_desk
    ticket_desk ||= TicketDesk.find(params[:ticket_desk_id])
  end

  def reservations
    reservations ||= ticket_desk.reservations
  end

  def reservation
    reservation ||= reservations.find(params[:id])
  end

  def screening
    screening ||= Screening.find(reservation_params[:screening_id])
  end

  def paid?
    ticket_desk.online
  end

  def tickets_params
    reservation_params[:tickets]
  end

  def set_resevation_params
    {
      paid: paid?,
      ticket_desk_id: params[:ticket_desk_id],
      client_id: reservation_params[:client_id],
      screening_id: reservation_params[:screening_id]
    }
  end

  def reservation_params
    params.require(:reservation).permit(
      :cinema_hall_id,
      :client_id,
      :screening_id,
      tickets: %i[price type seat movie_id]
    )
  end
end
