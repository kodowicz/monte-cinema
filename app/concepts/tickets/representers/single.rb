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
          hall: cinema_hall.name
        }
      end

      private

      def cinema_hall
        CinemaHalls::Repository.new.find(ticket.cinema_hall_id)
      end
    end
  end
end
