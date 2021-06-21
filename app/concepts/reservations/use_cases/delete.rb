# frozen_string_literal: true

module Reservations
  module UseCases
    class Delete
      attr_reader :repository

      def initialize(repository: Repository.new)
        @repository = repository
      end

      def call(user:, id:)
        reservation = repository.new.find(id)
        raise Pundit::NotAuthorizedError unless ReservationPolicy.new(user, reservation).destroy?

        repository.new.delete(id)
      end
    end
  end
end