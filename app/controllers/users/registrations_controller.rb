# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters

  def create
    build_resource(sign_up_params)
    resource.save
    # mailer
    sign_up(resource_name, resource)
    respond_with(resource)
  end

  private

  def respond_with(user, _opts = {})
    if user.persisted?
      render json: { user: user }, status: :ok
    else
      render json: { message: "failed" }, status: :failed_request
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :sign_up,
      keys: %i(first_name last_name role age phone_number real_user),
    )
  end
end
