# frozen_string_literal: true

module Repository
  class Base
    attr_reader :adapter

    def initialize(adapter:)
      @adapter = adapter
    end

    def find_all
      adapter.order(:id).all
    end

    def find(id)
      adapter.find(id)
    rescue ::ActiveRecord::ActiveRecordError => e
      raise_error(e.message)
    end

    def create(params)
      adapter.create(params)
    end

    def update(id, params)
      adapter.update(id, params)
    end

    def delete(id)
      adapter.destroy(id)
    end

    private

    def raise_error(message)
      raise Repository::Error, message
    end
  end
end
