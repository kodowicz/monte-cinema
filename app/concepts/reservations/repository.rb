module Reservations
  class Repository < ::Base::BaseRepository
    attr_reader :adapter

    def initialize(adapter: Reservation)
      super(adapter: adapter)
    end
  end
end
