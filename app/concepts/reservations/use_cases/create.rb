module Reservations
  module UseCases
    class Create
      ReservationInvalidError = Class.new(StandardError)

      attr_reader :repository, :params, :ticket_desk_id

      def initialize(params:, ticket_desk_id:, repository: Reservations::Repository.new)
        @repository = repository
        @params = params
        @ticket_desk_id = ticket_desk_id
      end

      def call
        Reservation.transaction do
          repository.create(reservation_params).tap do |reservation|
            raise ReservationInvalidError, "Couldn't create reservation" if reservation.invalid?

            Tickets::UseCases::CreateForReservation.new(
              reservation: reservation,
              screening: screening,
              tickets_params: tickets_params
            ).call
          end
        end
      end

      private

      def reservation_params
        reservation_params = params.merge(
          {
            ticket_desk_id: ticket_desk_id,
            expires_at: expires_at,
            status: status
          }
        )
        reservation_params.except(:tickets, :extended)
      end

      def tickets_params
        params[:tickets].map do |ticket|
          ticket.merge(
            {
              movie_id: screening.movie_id,
              cinema_hall_id: screening.cinema_hall_id
            }
          )
        end
      end

      def ticket_desk
        @ticket_desk ||= TicketDesks::Repository.new.find(ticket_desk_id)
      end

      def screening
        @screening ||= Screenings::Repository.new.find(params[:screening_id])
      end

      def expires_at
        screening.starts_at - 30.minute
      end

      def status
        ticket_desk.online ? "pending" : "paid"
      end
    end
  end
end
