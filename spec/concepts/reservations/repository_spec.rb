# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Reservations::Repository do
  describe '.create!' do
    let(:instance) { described_class.new }
    let(:params) { attributes_for :reservation }

    it 'creates reservation' do
      expect(instance.create!(params)).to be_a_kind_of(Reservation)
    end
  end
end
