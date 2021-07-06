# frozen_string_literal: true

module Movies
  class Repository < ::Base::BaseRepository
    attr_reader :adapter

    def initialize(adapter: Movie)
      super(adapter: adapter)
    end

    def find_popular(params_ratio:)
      ratio = params_ratio || Movie::MAX_RATIO
      adapter.where(ratio: ratio)
    end

    def find_order(order:)
      adapter.order(order)
    end

    def find_by(search:)
      adapter.order(ratio: :desc).where("title ILIKE ?", "%#{search}%")
    end

    def find_filter(filter:)
      adapter.order(ratio: :desc).where(filter)
    end

    def join_filter(filter:)
      adapter.joins(:screenings).where(screenings: filter)
    end
  end
end
