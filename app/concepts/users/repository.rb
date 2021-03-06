# frozen_string_literal: true

module Users
  class Repository < ::Repository::Base
    attr_reader :adapter

    def initialize(adapter: User)
      super(adapter: adapter)
    end

    def offline_user
      adapter.where(real_user: false).first
    end
  end
end
