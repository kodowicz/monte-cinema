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
          ticket_type: ticket.ticket_type
        }
      end
    end
  end
end
