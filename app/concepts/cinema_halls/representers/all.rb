module CinemaHalls
  module Representers
    class All
      attr_reader :cinema_halls

      def initialize(cinema_halls)
        @cinema_halls = cinema_halls
      end

      def basic
        cinema_halls.map do |cinema_hall|
          {
            id: cinema_hall.id,
            name: cinema_hall.name,
            capacity: cinema_hall.capacity
          }
        end
      end
    end
  end
end
