# frozen_string_literal: true

module Movies
  class Repository < ::Base::BaseRepository
    InvalidParamsError = Class.new(StandardError)

    attr_reader :adapter

    def initialize(adapter: Movie)
      super(adapter: adapter)
    end

    def find_popular(limit:)
      adapter.where(ratio: 5).limit(limit)
    end

    def find_order(order:)
      raise InvalidParamsError, "You can't order by #{order}" unless permit_order?(order)

      adapter.order(order)
    end

    def find_by(filter:, params:)
      adapter.where(filter, params)
    end

    private

    def permit_order?(order)
      %w[title starts_at].include?(order)
    end
  end
end
