# frozen_string_literal: true

module TicketDesks
  class Representer
    attr_reader :ticket_desk

    def initialize(ticket_desk)
      @ticket_desk = ticket_desk
    end

    def basic
      {
        id: ticket_desk.id,
        online: ticket_desk.online,
      }
    end
  end
end
