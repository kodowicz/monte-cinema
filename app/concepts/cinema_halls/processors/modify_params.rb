module CinemaHalls
  module Processors
    class ModifyParams
      attr_reader :seats

      def initialize(params:, seats:)
        @permit_params = params
        @seats = seats
      end

      def call
        if seats
          @permit_params[:seats] = seats if seats
          @permit_params[:not_available].map!(&:upcase)
        end
        @permit_params.except(:columns, :rows, :extended)
      end
    end
  end
end
