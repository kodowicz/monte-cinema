# frozen_string_literal: true

class TicketsController < ApplicationController
  def index
    tickets = Tickets::Repository.new.fetch_where(
      filter: {
        reservation_id: params[:reservation_id]
      }
    )

    render json: Tickets::Representers::All.new(tickets).basic, status: :ok
  end

  def show
    ticket = Tickets::Repository.new.find(params[:id])

    render json: Tickets::Representers::Single.new(ticket).basic, status: :ok
  end

  def destroy
    Tickets::Repository.new.delete(params[:id])
  end

  private

  def permit_params
    params.require(:ticket).permit(
      :seat,
      :ticket_type,
      :price,
      :reservation_id,
      :movie_id,
      :cinema_hall_id
    )
  end
end
