# frozen_string_literal: true

module Tickets
  class Repository < ::Repository::Base
    attr_reader :adapter

    def initialize(adapter: Ticket)
      super(adapter: adapter)
    end

    def find_filter(filter)
      adapter.where(filter)
    end

    def create!(params)
      adapter.create!(params)
    end
  end
end
