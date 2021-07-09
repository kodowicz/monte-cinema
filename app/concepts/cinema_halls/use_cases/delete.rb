# frozen_string_literal: true

module CinemaHalls
  module UseCases
    class Delete
      attr_reader :repository

      def initialize(repository: CinemaHalls::Repository.new)
        @repository = repository
      end

      def call(id:, user:)
        cinema_hall = repository.find(id)
        raise Pundit::NotAuthorizedError unless CinemaHallPolicy.new(user, cinema_hall).destroy?

        repository.delete(id)
      end
    end
  end
end
