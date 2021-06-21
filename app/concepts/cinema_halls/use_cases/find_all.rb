# frozen_string_literal: true

module CinemaHalls
  module UseCases
    class FindAll
      attr_reader :repository

      def initialize(repository: CinemaHalls::Repository.new)
        @repository = repository
      end

      def call(user:)
        raise Pundit::NotAuthorizedError unless CinemaHallPolicy.new(user, :cinema_hall).index?

        repository.find_all
      end
    end
  end
end
