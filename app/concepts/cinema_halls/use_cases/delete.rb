# frozen_string_literal: true

module CinemaHalls
  module UseCases
    class Delete
      attr_reader :repository

      def initialize(repository: Repository.new)
        @repository = repository
      end

      def call(id:, user:)
        cinema_hall = repository.new.find(id)
        raise Pundit::NotAuthorizedError unless CinemaHallPolicy.new(user, cinema_hall).destroy?

        repository.delete(id)
      end
    end
  end
end
