module CinemaHalls
  module UseCases
    class Create
      attr_reader :repository

      def initialize(repository: CinemaHalls::Repository.new)
        @repository = repository
      end

      def call(params:)
        seats = CinemaHalls::UseCases::CreateSeats.new(params: params).call
        params[:seats] = seats
        params.delete(:rows)
        params.delete(:columns)
        params.delete(:not_available)

        repository.create(params)
      end
    end
  end
end
