# frozen_string_literal: true

module CinemaHalls
  module UseCases
    class Create
      attr_reader :repository

      def initialize(repository: CinemaHalls::Repository.new)
        @repository = repository
      end

      def call(params:)
        seats = GenerateSeats.new(params: params).call
        permit_params = CinemaHalls::Processors::ModifyParams.new(params: params, seats: seats).call

        repository.create(permit_params)
      end
    end
  end
end
