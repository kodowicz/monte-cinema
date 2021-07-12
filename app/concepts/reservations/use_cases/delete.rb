# frozen_string_literal: true

module Reservations
  module UseCases
    class Delete
      attr_reader :repository

      def initialize(repository: Reservations::Repository.new)
        @repository = repository
      end

      def call(user:, id:)
        reservation = repository.find(id)
        raise Pundit::NotAuthorizedError unless ReservationPolicy.new(user, reservation).destroy?

        repository.delete(id)
      end
    end
  end
end
