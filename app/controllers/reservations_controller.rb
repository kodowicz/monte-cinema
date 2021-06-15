# frozen_string_literal: true

class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def index
    reservations = Reservations::Repository.new.find_filtred(
      filter: {
        ticket_desk_id: params[:ticket_desk_id]
      }
    )

    if show_params[:extended]
      render json: Reservations::Representers::All.new(reservations).extended
    else
      render json: Reservations::Representers::All.new(reservations).basic
    end
  end

  def show
    reservation = Reservations::Repository.new.find(params[:id])
    render json: Reservations::Representers::Single.new(reservation).extended
  end

  def create_online
    reservation = Reservations::UseCases::CreateOnline.new(params: online_params).call

    render json: Reservations::Representers::Single.new(reservation).extended, status: :created
  rescue Reservations::Repository::ReservationInvalidError => e
    render json: { error: e.message }.to_json, status: :unprocessable_entity
  rescue Tickets::UseCases::CreateForReservation::SeatsNotAvailableError => e
    render json: { error: e.message }.to_json, status: :unprocessable_entity
  end

  def create_offline
    reservation = Reservations::UseCases::CreateOffline.new(params: offline_params).call

    render json: Reservations::Representers::Single.new(reservation).extended, status: :created
  rescue Reservations::Repository::ReservationInvalidError => e
    render json: { error: e.message }.to_json, status: :unprocessable_entity
  rescue Tickets::UseCases::CreateForReservation::SeatsNotAvailableError => e
    render json: { error: e.message }.to_json, status: :unprocessable_entity
  end

  def destroy
    Reservations::Repository.new.delete(params[:id])
  end

  private

  def show_params
    params.require(:reservation).permit(:extended)
  end

  def online_params
    params.require(:reservation).permit(
      :user_id,
      :screening_id,
      tickets: %i[price ticket_type seat]
    )
  end

  def offline_params
    params.require(:reservation).permit(
      :screening_id,
      tickets: %i[price ticket_type seat]
    ).merge(
      {
        ticket_desk_id: params[:ticket_desk_id]
      }
    )
  end
end
