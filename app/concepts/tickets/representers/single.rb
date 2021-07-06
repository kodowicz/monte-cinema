# frozen_string_literal: true

module Tickets
  module Representers
    class Single
      attr_reader :ticket

      def initialize(ticket)
        @ticket = ticket
      end

      def basic
        {
          id: ticket.id,
          seat: ticket.seat,
          price: ticket.price,
          ticket_type: ticket.ticket_type,
          movie: movie,
          hall: hall,
        }
      end

      private

      def movie
        ticket.reservation.screening.movie.title
      end

      def hall
        ticket.reservation.screening.cinema_hall.name
      end
    end
  end
end
