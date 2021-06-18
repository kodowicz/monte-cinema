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
          expires_at: reservation.expires_at
        }
      end

      def extended
        {
          **basic,
          tickets: tickets
        }
      end

      private

      def tickets
        @tickets ||= Tickets::Representers::All.new(reservation.tickets).basic
      end
    end
  end
end
