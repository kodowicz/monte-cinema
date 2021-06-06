module Tickets
  module Representers
    class All
      attr_reader :tickets

      def initialize(tickets)
        @tickets = tickets
      end

      def basic
        tickets.map do |ticket|
          Single.new(ticket).basic
        end
      end

      def extended
        tickets.map do |ticket|
          Single.new(ticket).extended
        end
      end
    end
  end
end
