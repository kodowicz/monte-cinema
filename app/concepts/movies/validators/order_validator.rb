# frozen_string_literal: true

module Movies
  module Validators
    class OrderValidator
      ValidationError = Class.new StandardError

      ERROR_MESSAGES = {
        unvalid_order: "You can order by title or created_at",
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
        %w(title created_at).include?(order)
      end

      def raise_error
        raise ValidationError, "You can order only by title or created_at"
      end
    end
  end
end

# # frozen_string_literal: true

# module Movies
#   module Validators
#     class OrderParams < ::Dry::Validation::Contract
#       ORDER_TYPES = %w(title created_at).freeze

#       params do
#         required(:movie).filled.schema do
#           required(:order).filled(included_in?: ORDER_TYPES)
#           required(:pagination).filled.schema do
#             optional(:page).value(:integer)
#             optional(:items).value(:integer)
#           end
#         end
#       end

#       rule(:order) do
#         key.failure("You can order by title or created_at: #{ORDER_TYPES.join(", ")}.") unless value.in?(ORDER_TYPES)
#       end
#     end
#   end
# end
