# frozen_string_literal: true

module Movies
  module Validators
    class PaginationValidator
      ValidationError = Class.new StandardError

      ERROR_MESSAGES = {
        unprovided_pagination: 'You need to specify page and items',
        invalid_pagination: 'You provided wrong variables'
      }.freeze

      def initialize(pagination:)
        @pagination = pagination
      end

      def validate!
        pagination_present
        pagination_validation
      end

      attr_reader :pagination

      private

      def pagination_present
        return if pagination_provided?

        raise_error :unprovided_pagination
      end

      def pagination_validation
        return if pagination_valid?

        raise_error :invalid_pagination
      end

      def pagination_provided?
        pagination.key?('items' && 'page') && pagination.values.all?(&:present?)
      end

      def pagination_valid?
        pagination.values.all? do |value|
          value.integer? && value >= 1
        rescue StandardError
          false
        end
      end

      def raise_error(message_key)
        raise ValidationError, ERROR_MESSAGES[message_key]
      end
    end
  end
end
