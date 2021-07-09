# frozen_string_literal: true

module Tickets
  module UseCases
    class Delete
      attr_reader :repository

      def initialize(repository: Tickets::Repository.new)
        @repository = repository
      end

      def call(id:, user:)
        ticket = repository.find(id)
        raise Pundit::NotAuthorizedError unless TicketPolicy.new(user, ticket).destroy?

        repository.delete(id)
      end
    end
  end
end
