# frozen_string_literal: true

module Reservations
  module Representers
    class All
      attr_reader :reservations

      def initialize(reservations)
        @reservations = reservations.includes(:tickets)
      end

      def basic
        reservations.map do |reservation|
          Single.new(reservation).basic
        end
      end

      def extended
        reservations.map do |reservation|
          Single.new(reservation).extended
        end
      end
    end
  end
end
