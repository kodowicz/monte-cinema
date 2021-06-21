# frozen_string_literal: true

class ReservationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin? || user.employee?
        scope.all
      else
        scope.where(user_id: user.id)
      end
    end
  end

  def show?
    staff? || permit_user?
  end

  def create_offline?
    staff?
  end

  def create_online?
    staff? || client?
  end

  def update?
    staff?
  end

  def destroy?
    staff? || permit_user?
  end

  private

  attr_reader :user, :record

  def staff?
    user.admin? || user.employee?
  end

  def client?
    user.client?
  end

  def permit_user?
    record.user == user
  end
end
