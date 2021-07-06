# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  private

  def respond_with(user, _opts = {})
    render json: { user: user }, status: :ok
  end

  def respond_to_on_destroy
    render json: { message: "You are logged out." }, status: :ok
  end
end
