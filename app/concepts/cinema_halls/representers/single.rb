module CinemaHalls
  module Representers
    class Single
      attr_reader :cinema_hall

      def initialize(cinema_hall)
        @cinema_hall = cinema_hall
        @not_available = cinema_hall[:not_available]
        @seats = cinema_hall[:seats]
      end

      def basic
        {
          id: cinema_hall.id,
          name: cinema_hall.name,
          capacity: cinema_hall.capacity,
          seats: seats
        }
      end

      def extended
        {
          **basic,
          screenings: screenings
        }
      end

      private

      def screenings
        @screenings ||= Screenings::Representers::All.new(cinema_hall.screenings).basic
      end

      def seat_available?(seat)
        @not_available.exclude?(seat)
      end

      def seats
        @seats.map do |row|
          row.map do |seat|
            {
              seat: seat,
              available: seat_available?(seat)
            }
          end
        end
      end
    end
  end
end
