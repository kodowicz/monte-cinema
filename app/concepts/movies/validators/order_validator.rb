# frozen_string_literal: true

module Movies
  module Validators
    class OrderValidator
      ValidationError = Class.new StandardError

      ERROR_MESSAGES = {
        unvalid_order: 'You can order by title or created_at'
      }.freeze

      def initialize(params:)
        @params = params
      end

      def validate!
        order_validation
      end

      attr_reader :params

      private

      def order
        params[:order]
      end

      def order_validation
        return if permit_order?

        raise_error
      end

      def permit_order?
        %w[title created_at].include?(order)
      end

      def raise_error
        raise ValidationError, 'You can order only by title or created_at'
      end
    end
  end
end
