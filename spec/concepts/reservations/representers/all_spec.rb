require 'rails_helper'

RSpec.describe Reservations::Representers::All do
  let(:reservations) { create_list :reservation, 3, :with_tickets } 
  let(:instance) { described_class.new(reservations) }

  describe '.basic' do
    it 'returns proper hash' do
      expect(instance.basic).to eq(
        reservations.map do |reservation|
          {
            id: reservation.id,
            status: reservation.status,
            expires_at: reservation.expires_at
          }
        end
      )
    end
  end
  
  describe '.extended' do
    it 'returns proper hash' do
      expect(instance.extended).to eq(
        reservations.map do |reservation|
          {
            id: reservation.id,
            status: reservation.status,
            expires_at: reservation.expires_at,
            tickets: tickets_representer(reservation.tickets)
          }
        end
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
