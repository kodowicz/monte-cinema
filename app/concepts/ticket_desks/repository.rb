# frozen_string_literal: true

module TicketDesks
  class Repository < ::Repository::Base
    attr_reader :adapter

    def initialize(adapter: TicketDesk)
      super(adapter: adapter)
    end

    def online
      adapter.where(online: true).first
    end
  end
end
