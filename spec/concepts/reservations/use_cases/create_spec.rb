# frozen_string_literal: true

require "rails_helper"

RSpec.describe Reservations::UseCases::Create do
  describe ".call!" do
    let(:params) { attributes_for :reservation }
    let(:instance) { described_class.new(params: params) }

    context "when provided valid params" do
      it "creates reservation" do
        expect { instance.call! }.to change(Reservation, :count).by(1)
      end

      it "returns reservation" do
        expect(instance.call!).to be_a_kind_of(Reservation)
      end
    end

    context "when provided invalid params" do
      let(:instance) { described_class.new(params: {}) }
      let(:error) { described_class::ReservationInvalidError }

      it "raises ReservationInvalidError" do
        expect { raise error }.to raise_error
      end
    end
  end
end
