# frozen_string_literal: true

module UseCase
  class Base
    attr_reader :params, :errors

    def initialize(params:)
      @params = params
      @errors = []
    end

    private

    def success?
      errors.empty?
    end

    def validate_params
      validator.new.call(params.to_h).tap do |result|
        result_errors = format_errors(result.errors)

        add_errors(result_errors) unless result.success?
      end
    end

    def format_errors(result_errors)
      result_errors.map do |error|
        { error.path.first => error.text }
      end
    end

    def add_error(message)
      errors.append(message)
    end

    def add_errors(errors)
      errors.each { |error| add_error(error) }
    end
  end
end
