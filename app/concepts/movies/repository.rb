# frozen_string_literal: true

module Movies
  class Repository < ::Base::BaseRepository
    attr_reader :adapter

    def initialize(adapter: Movie)
      super(adapter: adapter)
    end

    def find_popular(limit:)
      adapter.where(ratio: 5).limit(limit)
    end

    def find_by(filter:, params:)
      adapter.where(filter, params)
    end
  end
end
