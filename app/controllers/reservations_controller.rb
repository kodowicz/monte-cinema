# frozen_string_literal: true

class ReservationsController < ApplicationController
  def index
    reservations = Reservations::Repository.new.find_filtred(
      filter: {
        ticket_desk_id: params[:ticket_desk_id]
      }
    )

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
    reservation = Reservations::UseCases::Create.new(
      params: permit_params,
      ticket_desk_id: params[:ticket_desk_id]
    ).call

    render json: Reservations::Representers::Single.new(reservation).extended, status: :ok
    rescue Reservations::UseCases::Create::ReservationInvalidError => error
      render json: { error: error.message }.to_json, status: :unprocessable_entity
    rescue Tickets::UseCases::CreateForReservation::SeatsNotAvailableError => error
      render json: { error: error.message }.to_json, status: :unprocessable_entity
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
