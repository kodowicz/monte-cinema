module CinemaHalls
  module Processors
    class ModifyParams
      attr_reader :params, :seats

      def initialize(params:, seats:)
        @permit_params = params
        @seats = seats
      end

      def call
        @permit_params[:seats] = seats
        @permit_params[:not_available].map!(&:upcase)
        @permit_params.except(:columns, :rows)
      end
    end
  end
end
