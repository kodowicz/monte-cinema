# frozen_string_literal: true

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
    end
  end
end
