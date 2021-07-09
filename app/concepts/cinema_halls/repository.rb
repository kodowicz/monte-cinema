# frozen_string_literal: true

module CinemaHalls
  class Repository < ::Repository::Base
    attr_reader :adapter

    def initialize(adapter: CinemaHall)
      super(adapter: adapter)
    end
  end
end
