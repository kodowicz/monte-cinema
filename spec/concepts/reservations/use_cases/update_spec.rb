# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Reservations::UseCases::Update do
  describe '.call' do
    context 'user is authorized' do
      let(:admin) { create :admin }
      let(:reservation) { create :unpaid_reservation }
      let(:params) { { status: 'paid' } }
      let(:instance) { described_class.new }

      it 'updates reservation status' do
        expect { instance.call(params: params, user: admin, id: reservation.id) }
          .to change { reservation.reload.status }.from('created').to('paid')
      end

      it 'returns reservation' do
        expect(instance.call(params: params, user: admin, id: reservation.id)).to eq(reservation)
      end
    end

    context 'user is not authorized' do
      let(:user) { create :user }
      let(:reservation) { create :unpaid_reservation, user: user }
      let(:params) { { status: 'paid' } }
      let(:instance) { described_class.new }
      let(:error) { Pundit::NotAuthorizedError }

      it 'raises Pundit::NotAuthorizedError' do
        instance.call(params: params, user: user, id: reservation.id)
        expect { raise error }.to raise_error
      end
    end
  end
end
