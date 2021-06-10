# frozen_string_literal: true

module Reservations
  module UseCases
    class CreateOffline
      ReservationInvalidError = Class.new(StandardError)

      attr_reader :repository, :params

      def initialize(params:, repository: Reservations::Repository.new)
        @repository = repository
        @params = params
      end

      def call
        Reservation.transaction do
          repository.create(reservation_params).tap do |reservation|
            raise ReservationInvalidError, "Couldn't create reservation" unless reservation.valid?

            Tickets::UseCases::CreateForReservation.new(
              tickets_params: params[:tickets],
              reservation: reservation,
              screening: screening
            ).call
          end
        end
      end

      private

      def reservation_params
        {
          ticket_desk_id: params[:ticket_desk_id],
          screening_id: params[:screening_id],
          client_id: offline_client.id,
          expires_at: expires_at,
          status: 'paid'
        }
      end

      def screening
        @screening ||= Screenings::Repository.new.find(params[:screening_id])
      end

      def offline_client
        @offline_client ||= Clients::Repository.new.offline_client
      end

      def expires_at
        screening.starts_at - 30.minute
      end
    end
  end
end
