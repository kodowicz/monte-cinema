# frozen_string_literal: true

class Base::BaseRepository
  attr_reader :adapter

  def initialize(adapter:)
    @adapter = adapter
  end

  def raise_error(error_message)
    raise Repository::Error, error_message
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
end
