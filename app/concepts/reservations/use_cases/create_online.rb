# frozen_string_literal: true

module Reservations
  module UseCases
    class CreateOnline
      attr_reader :repository, :user, :params

      def initialize(user:, params:, repository: Reservations::Repository.new)
        @repository = repository
        @params = params
        @user = user
      end

      def call
        raise Pundit::NotAuthorizedError unless ReservationPolicy.new(user, :reservation).create_online?

        Reservation.transaction do
          Create.new(params: reservation_params).call!.tap do |reservation|
            Tickets::UseCases::CreateForReservation.new(
              tickets_params: params[:tickets],
              reservation: reservation,
              screening: screening
            ).call

            CancelReservationsJob.set(wait_until: expires_at).perform_later(reservation.id)
          end
        end
      end

      private

      def reservation_params
        {
          screening_id: params[:screening_id],
          user_id: user.id,
          ticket_desk_id: ticket_desk_online,
          expires_at: expires_at,
          status: 'created'
        }
      end

      def ticket_desk_online
        TicketDesks::Repository.new.online.id
      end

      def screening
        @screening ||= Screenings::Repository.new.find(params[:screening_id])
      end

      def expires_at
        screening.starts_at - 30.minutes
      end
    end
  end
end
