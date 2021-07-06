# frozen_string_literal: true

require "rails_helper"
require "spec_helper"

RSpec.describe CancelReservationsJob, type: :job do
  describe "#perform_later" do
    let(:destroy_repository) { instance_double(Reservations::Repository.new, call: true) }

    it "enqueues reservation timeout process" do
      ActiveJob::Base.queue_adapter = :test
      expect { described_class.perform_later("reservation") }.to have_enqueued_job
    end

    context "when cancel reservation job is executed" do
      let!(:unpaid_reservation) { create(:unpaid_reservation) }
      let!(:paid_reservation) { create(:paid_reservation) }

      it "deletes record if unpaid" do
        expect { described_class.perform_now(unpaid_reservation.id) }.to change(Reservation, :count).by(-1)
      end

      it "does not delete record if unpaid" do
        expect { described_class.perform_now(paid_reservation.id) }.to change(Reservation, :count).by(0)
      end
    end
  end
end
