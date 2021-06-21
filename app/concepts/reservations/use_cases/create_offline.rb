# frozen_string_literal: true

module Reservations
  module UseCases
    class CreateOffline
      attr_reader :repository, :params, :user

      def initialize(params:, user:, repository: Reservations::Repository.new)
        @repository = repository
        @params = params
        @user = user
      end

      def call
        raise Pundit::NotAuthorizedError unless ReservationPolicy.new(user, :reservation).create_offline?

        Reservation.transaction do
          Create.new(params: reservation_params).call!.tap do |reservation|
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
          user_id: offline_user.id,
          expires_at: expires_at,
          status: 'paid'
        }
      end

      def screening
        @screening ||= Screenings::Repository.new.find(params[:screening_id])
      end

      def offline_user
        @offline_user ||= Users::Repository.new.offline_user
      end

      def expires_at
        screening.starts_at - 30.minutes
      end
    end
  end
end
