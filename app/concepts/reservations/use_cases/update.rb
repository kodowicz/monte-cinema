# frozen_string_literal: true

module Reservations
  module UseCases
    class Update
      attr_reader :repository

      def initialize(repository: Repository.new)
        @repository = repository
      end

      def call(params:, user:, id:)
        reservation = repository.new.find(id)
        raise Pundit::NotAuthorizedError unless ReservationPolicy.new(user, reservation).update?

        repository.new.update(id, params)
      end
    end
  end
end
