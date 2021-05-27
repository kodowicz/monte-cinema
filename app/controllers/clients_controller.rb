class ClientsController < ApplicationController
  def show
    client = Client
      .where(email: [client_params[:email]])
      .or(Client.where(id: params[:id]))

    render json: client
  end

  def create
    client = Client.create(client_params)

    if client.valid?
      render json: client, status: :created
    else
      render json: client.errors, status: :unprocessable_entity
    end
  end

  private

  def client_params
    params.require(:client).permit(:email, :name, :age, :real_user)
  end
end
