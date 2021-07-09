# frozen_string_literal: true

module Validator
  class Error < StandardError
    def initialize(messages)
      @messages = messages
      super
    end

    attr_reader :messages
  end
end
