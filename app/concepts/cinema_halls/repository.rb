# frozen_string_literal: true

module CinemaHalls
  class Repository < ::Base::BaseRepository
    attr_reader :adapter

    def initialize(adapter: CinemaHall)
      super(adapter: adapter)
    end
  end
end
