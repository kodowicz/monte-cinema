# frozen_string_literal: true

class ReservationsController < ApplicationController
  before_action :authenticate_user!

  rescue_from Reservations::UseCases::Create::ReservationInvalidError, with: :invalid_request
  rescue_from Tickets::UseCases::CreateForReservation::SeatsNotAvailableError, with: :invalid_request

  def index
    reservations = policy_scope(Reservations::Repository.new.find_all)

    if show_params[:extended]
      render json: { reservations: Reservations::Representers::All.new(reservations).extended }
    else
      render json: { reservations: Reservations::Representers::All.new(reservations).basic }
    end
  end

  def show
    reservation = Reservations::Repository.new.find(params[:id])
    authorize reservation
    render json: { reservation: Reservations::Representers::Single.new(reservation).extended }
  end

  def create_online
    reservation = Reservations::UseCases::CreateOnline.new(
      user: current_user,
      params: online_params
    ).call

    render json: { reservation: Reservations::Representers::Single.new(reservation).extended }, status: :created
  end

  def create_offline
    reservation = Reservations::UseCases::CreateOffline.new(
      params: offline_params.merge({ ticket_desk_id: params[:ticket_desk_id] }),
      user: current_user
    ).call

    render json: { reservation: Reservations::Representers::Single.new(reservation).extended }, status: :created
  end

  def update
    reservation = Reservations::UseCases::Update.new.call(
      params: update_params,
      user: current_user,
      id: params[:id]
    )
    render json: { reservation: Reservations::Representers::Single.new(reservation).basic }
  end

  def destroy
    Reservations::UseCases::Delete.new.call(
      user: current_user,
      id: params[:id]
    )
    render json: { message: 'Reservation canceled' }
  end

  private

  def invalid_request(error)
    render json: { error: error.message }.to_json, status: :unprocessable_entity
  end

  def show_params
    params.require(:reservation).permit(:extended)
  end

  def online_params
    params.require(:reservation).permit(
      :screening_id,
      tickets: %i[price ticket_type seat]
    )
  end

  def offline_params
    params.require(:reservation).permit(
      :screening_id,
      tickets: %i[price ticket_type seat]
    )
  end

  def update_params
    params.require(:reservation).permit(:status)
  end
end
