module CinemaHalls
  module Representers
    class All
      attr_reader :cinema_halls

      def initialize(cinema_halls)
        @cinema_halls = cinema_halls
      end

      def basic
        cinema_halls.map do |cinema_hall|
          Single.new(cinema_hall).basic
        end
      end
    end
  end
end
