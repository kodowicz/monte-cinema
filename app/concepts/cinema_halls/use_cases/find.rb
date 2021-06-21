# frozen_string_literal: true

module CinemaHalls
  module UseCases
    class Find
      attr_reader :repository

      def initialize(repository: CinemaHalls::Repository.new)
        @repository = repository
      end

      def call(id:, user:)
        raise Pundit::NotAuthorizedError unless CinemaHallPolicy.new(user, :cinema_hall).show?

        repository.find(id)
      end
    end
  end
end
