# frozen_string_literal: true

module Reservations
  module Representers
    class Single
      attr_reader :reservation

      def initialize(reservation)
        @reservation = reservation
      end

      def basic
        {
          id: reservation.id,
          status: reservation.status,
          expires_at: format_date,
        }
      end

      def extended
        {
          **basic,
          tickets: tickets,
        }
      end

      private

      def tickets
        @tickets ||= Tickets::Representers::All.new(reservation.tickets).basic
      end

      def format_date
        reservation.expires_at.strftime("%I:%M %p, %d.%m.%Y")
      end
    end
  end
end
