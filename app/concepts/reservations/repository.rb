# frozen_string_literal: true

module Reservations
  class Repository < ::Base::BaseRepository
    attr_reader :adapter

    def initialize(adapter: Reservation)
      super(adapter: adapter)
    end

    def create!(params)
      adapter.create!(params)
    end
  end
end
