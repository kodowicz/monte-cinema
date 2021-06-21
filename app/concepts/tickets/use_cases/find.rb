# frozen_string_literal: true

module Tickets
  module UseCases
    class Find
      attr_reader :repository

      def initialize(repository: Repository.new)
        @repository = repository
      end

      def call(id:, user:)
        ticket = repository.find(id)
        raise Pundit::NotAuthorizedError unless TicketPolicy.new(user, ticket).show?

        ticket
      end
    end
  end
end
