module Tickets
  class Repository < ::Base::BaseRepository
    attr_reader :adapter

    def initialize(adapter: Ticket)
      super(adapter: adapter)
    end
  end
end
