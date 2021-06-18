# frozen_string_literal: true

module Screenings
  module Representers
    class All
      attr_reader :screenings

      def initialize(screenings)
        @screenings = screenings
      end

      def basic
        screenings.map do |screening|
          Single.new(screening).basic
        end
      end

      def extended
        screenings.map do |screening|
          Single.new(screening).extended
        end
      end
    end
  end
end
