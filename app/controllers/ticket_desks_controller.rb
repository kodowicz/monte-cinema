# frozen_string_literal: true

class TicketDesksController < ApplicationController
  def show
    ticket_desk = TicketDesks::Repository.new.find(params[:id])
    render json: { ticket_desk: TicketDesks::Representer.new(ticket_desk).basic }
  end
end
