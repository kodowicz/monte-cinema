# frozen_string_literal: true

class TicketDesksController < ApplicationController
  def show
    ticket_desk = TicketDesk.Repository.find(params[:id])
    render json: { ticket_desk: ticket_desk }
  end
end
