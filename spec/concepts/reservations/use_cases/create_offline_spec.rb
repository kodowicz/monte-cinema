# frozen_string_literal: true

require "rails_helper"

RSpec.describe Reservations::UseCases::CreateOffline do
  describe ".call" do
    let!(:fake_user) { create :fake_user }
    let!(:admin) { create :admin }
    let(:ticket_desk) { create :ticket_desk }
    let(:screening) { create :screening }
    let(:params) do
      {
        screening_id: screening.id,
        ticket_desk_id: ticket_desk.id,
        tickets: [
          { seat: "A1", price: 15, ticket_type: "normal" },
        ],
      }
    end
    let(:instance) { described_class.new(user: admin, params: params) }

    it "creates reservation" do
      expect { instance.call }.to change(Reservation, :count).by(1)
    end

    it "returns reservation" do
      expect(instance.call).to be_a_kind_of(Reservation)
    end
  end
end
