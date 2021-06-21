# frozen_string_literal: true

module CinemaHalls
  module UseCases
    class Update
      attr_reader :repository

      def initialize(repository: Repository.new)
        @repository = repository
      end

      def call(id:, params:)
        cinema_hall = repository.new.find(id)
        raise Pundit::NotAuthorizedError unless CinemaHallPolicy.new(user, cinema_hall).update?

        repository.update(id, params)
      end
    end
  end
end
