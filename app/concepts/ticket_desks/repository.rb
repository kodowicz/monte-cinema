module TicketDesks
  class Repository < ::Base::BaseRepository
    attr_reader :adapter

    def initialize(adapter: TicketDesk)
      super(adapter: adapter)
    end

    def online
      adapter.where(online: true).first
    end
  end
end
