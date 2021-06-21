# frozen_string_literal: true

class TicketPolicy < ApplicationPolicy
  attr_reader :user, :record

  def index?
    staff? || permit_user?
  end

  def show?
    staff? || permit_user?
  end

  def destroy?
    staff? || permit_user?
  end

  private

  def staff?
    user.admin? || user.employee?
  end

  def permit_user?
    record.reservation.user == user
  end
end
