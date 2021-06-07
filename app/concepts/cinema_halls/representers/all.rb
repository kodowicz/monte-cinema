module CinemaHalls
  module Representers
    class All
      attr_reader :cinema_halls

      def initialize(cinema_halls)
        @cinema_halls = cinema_halls.includes(:screenings)
      end

      def basic
        cinema_halls.map do |cinema_hall|
          Single.new(cinema_hall).basic
        end
      end

      def extended
        cinema_halls.map do |cinema_hall|
          Single.new(cinema_hall).extended
        end
      end
    end
  end
end
