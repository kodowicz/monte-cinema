module Tickets
  class Repository < ::Base::BaseRepository
    attr_reader :adapter

    def initialize(adapter: Ticket)
      super(adapter: adapter)
    end

    def fetch_where(filter:)
      adapter.where(filter)
    end
  end
end
