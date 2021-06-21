# frozen_string_literal: true

class TicketsController < ApplicationController
  before_action :authenticate_user!

  def index
    tickets = Tickets::UseCases::FindFilter.new.call(
      filter: { reservation_id: params[:reservation_id] },
      user: current_user
    )

    render json: Tickets::Representers::All.new(tickets).basic
  end

  def show
    ticket = Tickets::UseCases::Find.new.call(id: params[:id], user: current_user)

    render json: Tickets::Representers::Single.new(ticket).basic
  end

  def destroy
    Tickets::UseCases::Find.new.call.delete(id: params[:id], user: current_user)
  end
end
