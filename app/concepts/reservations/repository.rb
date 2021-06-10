# frozen_string_literal: true

module Reservations
  class Repository < ::Base::BaseRepository
    ReservationInvalidError = Class.new(StandardError)

    attr_reader :adapter

    def initialize(adapter: Reservation)
      super(adapter: adapter)
    end

    def find_filtred(filter:)
      adapter.where(filter)
    end

    def create!(params)
      adapter.create!(params)
    rescue ActiveRecord::RecordInvalid
      raise ReservationInvalidError, "Couldn't create reservation"
    end
  end
end
