# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  private

  def respond_with(user, _opts = {})
    if user.persisted?
      render json: { user: user }, status: :ok
    else
      render json: { message: 'failed' }, status: :failed_request
    end
  end
end
