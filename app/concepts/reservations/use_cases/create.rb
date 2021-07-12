# frozen_string_literal: true

module Reservations
  module UseCases
    class Create
      ReservationInvalidError = Class.new(StandardError)

      attr_reader :repository, :params

      def initialize(params:, repository: Reservations::Repository.new)
        @repository = repository
        @params = params
      end

      def call!
        Reservation.transaction do
          repository.create!(params)
        end
      rescue ActiveRecord::RecordInvalid
        raise ReservationInvalidError, "Couldn't create reservation"
      end
    end
  end
end
