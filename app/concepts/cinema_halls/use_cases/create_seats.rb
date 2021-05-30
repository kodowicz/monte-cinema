module CinemaHalls
  module UseCases
    class CreateSeats
      attr_reader :params

      def initialize(params:)
        @params = params
      end

      def call
        columns = to_range(@params[:columns])
        rows = to_range(@params[:rows])

        create_seats(rows, columns)
      end

      private

      def to_range(array)
        Range.new(array.first, array.last)
      end

      def not_available
        @params[:not_available].map(&:upcase)
      end

      def seat_available?(seat)
        not_available.exclude? seat
      end

      def create_seats(rows, columns)
        rows.map do |row|
          columns.map do |column|
            seat = "#{row}#{column}"
            available = seat_available? seat

            {
              seat: seat,
              available: available
            }
          end
        end
      end
    end
  end
end
