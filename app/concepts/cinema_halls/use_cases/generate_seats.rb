# frozen_string_literal: true

module CinemaHalls
  module UseCases
    class GenerateSeats
      attr_reader :params

      def initialize(params:)
        @params = params
      end

      def call
        columns = to_range(params[:columns])
        rows = to_range(params[:rows])

        generate_seats(rows, columns)
      end

      private

      def to_range(array)
        Range.new(array.first, array.last)
      end

      def generate_seats(rows, columns)
        rows.map do |row|
          columns.map do |column|
            "#{row}#{column}"
          end
        end
      end
    end
  end
end
