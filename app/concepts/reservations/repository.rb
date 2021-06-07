module Reservations
  class Repository < ::Base::BaseRepository
    attr_reader :adapter

    def initialize(adapter: Reservation)
      super(adapter: adapter)
    end

    def find_filtred(filter:)
      adapter.where(filter)
    end
  end
end
