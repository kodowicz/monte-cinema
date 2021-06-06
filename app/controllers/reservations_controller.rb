# frozen_string_literal: true

class ReservationsController < ApplicationController
  def index
    reservations = Reservations::Repository.new.find_all

    if permit_params[:extended]
      render json: Reservations::Representers::All.new(reservations).extended
    else
      render json: Reservations::Representers::All.new(reservations).basic
    end
  end

  def show
    reservation = Reservations::Repository.new.find(params[:id])

    if permit_params[:extended]
      render json: Reservations::Representers::Single.new(reservation).extended
    else
      render json: Reservations::Representers::Single.new(reservation).basic
    end
  end

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

  def update
    if @reservation.update(permit_params)
      render json: render_reservation(@reservation), status: :ok
    else
      render json: @reservation.errors, status: :unprocessable_entity
    end
  end

  def destroy
    Reservations::Repository.new.delete(params[:id])
  end

  private

  def permit_params
    params.require(:reservation).permit(
      :extended,
      :client_id,
      :screening_id,
      tickets: %i[price ticket_type seat movie_id]
    )
  end
end
