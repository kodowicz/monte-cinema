# frozen_string_literal: true

module Tickets
  module UseCases
    class FindFilter
      attr_reader :repository

      def initialize(repository: Repository.new)
        @repository = repository
      end

      def call(user:, filter:)
        tickets = repository.find_filter(filter)
        raise Pundit::NotAuthorizedError unless TicketPolicy.new(user, tickets.first).index?

        tickets
      end
    end
  end
end
