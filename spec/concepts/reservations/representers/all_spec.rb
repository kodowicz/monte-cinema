# frozen_string_literal: true

require "rails_helper"

RSpec.describe Reservations::Representers::All do
  let(:reservations) { create_list :reservation, 3, :with_tickets }
  let(:instance) { described_class.new(Reservation.where(id: reservations.map(&:id))) }

  describe ".basic" do
    it "returns proper hash" do
      expect(instance.basic).to eq(
        reservations.map do |reservation|
          {
            id: reservation.id,
            status: reservation.status,
            expires_at: reservation.expires_at.strftime("%I:%M %p, %d.%m.%Y"),
          }
        end,
      )
    end
  end

  describe ".extended" do
    it "returns proper hash" do
      expect(instance.extended).to eq(
        reservations.map do |reservation|
          {
            id: reservation.id,
            status: reservation.status,
            expires_at: reservation.expires_at.strftime("%I:%M %p, %d.%m.%Y"),
            tickets: tickets_representer(reservation.tickets),
          }
        end,
      )
    end
  end
end

private

def tickets_representer(tickets)
  tickets.map do |ticket|
    {
      id: ticket.id,
      seat: ticket.seat,
      price: ticket.price,
      ticket_type: ticket.ticket_type,
      movie: ticket.reservation.screening.movie.title,
      hall: ticket.reservation.screening.cinema_hall.name,
    }
  end
end
