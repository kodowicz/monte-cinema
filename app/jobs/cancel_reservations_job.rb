# frozen_string_literal: true

class CancelReservationsJob < ApplicationJob
  queue_as :default

  def perform(reservation_id)
    reservation = Reservations::Repository.new.find(reservation_id)
    Reservations::Repository.new.delete(reservation.id) unless reservation.paid?
  end
end
