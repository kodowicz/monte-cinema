# frozen_string_literal: true

require "rails_helper"

RSpec.describe Reservations::UseCases::CreateOnline do
  describe ".call" do
    let(:user) { create :user }
    let(:screening) { create :screening }
    let(:params) do
      {
        screening_id: screening.id,
        tickets: [
          { seat: "A1", price: 15, ticket_type: "normal" },
        ],
      }
    end
    let(:instance) { described_class.new(params: params, user: user) }

    it "creates reservation" do
      expect { instance.call }.to change(Reservation, :count).by(1)
    end

    it "returns reservation" do
      expect(instance.call).to be_a_kind_of(Reservation)
    end
  end
end
