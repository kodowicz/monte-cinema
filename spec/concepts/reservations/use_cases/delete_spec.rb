# frozen_string_literal: true

require "rails_helper"

RSpec.describe Reservations::UseCases::Delete do
  describe ".call" do
    context "when user is authorized" do
      context "when user is an admin" do
        let(:admin) { create :admin }
        let(:reservation) { create :unpaid_reservation }
        let(:instance) { described_class.new }

        it "deletes reservation record" do
          instance.call(user: admin, id: reservation.id)
          expect(Reservation.find_by(id: reservation.id)).to eq(nil)
        end
      end

      context "when user is an owner" do
        let(:user) { create :user }
        let(:reservation) { create :unpaid_reservation, user: user }
        let(:instance) { described_class.new }

        it "deletes reservation record" do
          instance.call(user: user, id: reservation.id)
          expect(Reservation.find_by(id: reservation.id)).to eq(nil)
        end
      end
    end

    context "when user is not authorized" do
      let(:user) { create :user }
      let(:owner) { create :user }
      let(:reservation) { create :unpaid_reservation, user: owner }
      let(:instance) { described_class.new(user: user, id: reservation.id) }
      let(:error) { Pundit::NotAuthorizedError }

      it "raises Pundit::NotAuthorizedError" do
        expect { raise error }.to raise_error
      end
    end
  end
end
