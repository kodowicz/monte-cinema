# frozen_string_literal: true

class ReservationsController < ApplicationController
  before_action :set_reservation, only: %i[show update destroy]

  # GET /reservations
  def index
    @reservations = Reservation.all.map do |res|
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
    @reservation = Reservation.create(reservation_params)

    if @reservation.save
      render json: @reservation, status: :created, location: @reservation
    else
      render json: @reservation.errors, status: :unprocessable_entity
    end
  end

  # PUT /reservations/:reservation_id
  def update
    if @reservation.update!(reservation_params)
      render json: @reservation, status: :ok
    else
      render json: @reservation.errors, status: :unprocessable_entity
    end
  end

  # DELETE /reservations/:reservation_id
  def destroy
    if @reservation.destroy!
      render json: @reservation, status: :ok
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
    @reservation = Reservation.find(params[:id])
  end

  def reservation_params
    params.require(:reservation).permit(:paid)
  end
end
