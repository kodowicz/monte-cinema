# frozen_string_literal: true

module Reservations
  module UseCases
    class Update
      attr_reader :repository

      def initialize(repository: Reservations::Repository.new)
        @repository = repository
      end

      def call(params:, user:, id:)
        reservation = repository.find(id)
        raise Pundit::NotAuthorizedError unless ReservationPolicy.new(user, reservation).update?

        repository.update(id, params)
      end
    end
  end
end
