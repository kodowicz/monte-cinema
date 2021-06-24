# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from Repository::Error, with: :user_not_authorized

  def user_not_authorized
    render json: { error: 'This action is not permitted' }.to_json, status: :unauthorized
  end
end
