# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Reservations::Representers::Single do
  describe '.basic' do
    let(:reservation) { create :reservation }
    let(:instance) { described_class.new(reservation) }
    let(:tickets_representer) do |tickets|
      tickets.map do |ticket|
        {
          id: ticket.id,
          seat: ticket.seat,
          price: ticket.price,
          ticket_type: ticket.ticket_type,
          movie: ticket.reservation.screening.movie.title,
          hall: ticket.reservation.screening.cinema_hall.name
        }
      end
    end

    it 'returns proper hash' do
      expect(instance.basic).to eq(
        {
          id: reservation.id,
          status: reservation.status,
          expires_at: reservation.expires_at.strftime("%I:%M %p, %d.%m.%Y")
        }
      )
    end
  end

  describe '.extended' do
    let(:reservation) { create :reservation, :with_tickets }
    let(:instance) { described_class.new(reservation) }

    it 'returns proper hash' do
      expect(instance.extended).to eq(
        {
          id: reservation.id,
          status: reservation.status,
          expires_at: reservation.expires_at.strftime("%I:%M %p, %d.%m.%Y"),
          tickets: tickets_representer(reservation.tickets)
        }
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
      hall: ticket.reservation.screening.cinema_hall.name
    }
  end
end
