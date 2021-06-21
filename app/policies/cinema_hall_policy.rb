# frozen_string_literal: true

class CinemaHallPolicy < ApplicationPolicy
  def index?
    staff?
  end

  def show?
    staff?
  end

  def update?
    staff?
  end

  def destroy?
    staff?
  end

  private

  attr_reader :user

  def staff?
    user.admin? || user.employee?
  end
end
