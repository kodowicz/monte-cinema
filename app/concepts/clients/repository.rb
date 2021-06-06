module Clients
  class Repository < ::Base::BaseRepository
    attr_reader :adapter

    def initialize(adapter: Client)
      super(adapter: adapter)
    end

    def fake_client
      adapter.where(real_user: false)
    end
  end
end
