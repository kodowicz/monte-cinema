# frozen_string_literal: true

module Tickets
  module UseCases
    class CreateForReservation
      SeatsNotAvailableError = Class.new(StandardError)

      attr_reader :reservation, :screening, :tickets_params

      def initialize(reservation:, screening:, tickets_params: [])
        @tickets_params = tickets_params
        @reservation = reservation
        @screening = screening
      end

      def call
        Ticket.transaction do
          raise SeatsNotAvailableError, "Can't create reservation without tickets" if tickets_params.empty?
          raise SeatsNotAvailableError, 'Every seats are taken' if available_seats.empty?
          raise SeatsNotAvailableError, 'Provided seat are not available' unless available?

          tickets_params.each do |params|
            reservation.tickets.create!(params)
          rescue ActiveRecord::RecordInvalid
            raise SeatsNotAvailableError, 'Provided parameters are invalid'
          end
        end
      end

      private

      def available?
        seats.all? do |seat|
          available_seats.include? seat
        end
      end

      def available_seats
        @available_seats ||= Screenings::Repository.new.available_seats(screening)
      end

      def seats
        tickets_params.map { |ticket| ticket[:seat] }
      end
    end
  end
end
