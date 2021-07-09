# frozen_string_literal: true

module Movies
  module UseCases
    class FindOrder
      InvalidParamsError = Class.new StandardError

      attr_reader :repository, :params

      def initialize(params:, repository: Movies::Repository.new)
        @repository = repository
        @params = params
      end

      def call
        Validators::OrderValidator.new(params: params).validate!
        Validators::PaginationValidator.new(pagination: params[:pagination]).validate!

        repository.find_order(order: params[:order])
      end
    end
  end
end
