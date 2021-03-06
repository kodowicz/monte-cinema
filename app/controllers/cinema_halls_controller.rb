# frozen_string_literal: true

class CinemaHallsController < ApplicationController
  before_action :authenticate_user!

  def index
    cinema_halls = CinemaHalls::UseCases::FindAll.new.call(user: current_user)

    if permit_params[:extended]
      render json: { halls: CinemaHalls::Representers::All.new(cinema_halls).extended }
    else
      render json: { halls: CinemaHalls::Representers::All.new(cinema_halls).basic }
    end
  end

  def show
    cinema_hall = CinemaHalls::UseCases::Find.new.call(id: params[:id], user: current_user)

    if permit_params[:extended]
      render json: { hall: CinemaHalls::Representers::Single.new(cinema_hall).extended }
    else
      render json: { hall: CinemaHalls::Representers::Single.new(cinema_hall).basic }
    end
  end

  def create
    cinema_hall = CinemaHalls::UseCases::Create.new.call(params: permit_params, user: current_user)

    if cinema_hall.valid?
      render json: { hall: CinemaHalls::Representers::Single.new(cinema_hall).basic }, status: :created
    else
      render json: { error: cinema_hall.errors }.to_json, status: :unprocessable_entity
    end
  end

  def update
    cinema_hall = 
      CinemaHalls::UseCases::Update.new.call(
        id: params[:id],
        params: permit_params,
        user: current_user,
      )

    if cinema_hall.valid?
      render json: { hall: CinemaHalls::Representers::Single.new(cinema_hall).basic }
    else
      render json: { error: cinema_hall.errors }.to_json, status: :unprocessable_entity
    end
  end

  def destroy
    CinemaHalls::UseCases::Delete.new.call(id: params[:id], user: current_user)
  end

  private

  def permit_params
    params.require(:cinema_hall).permit(
      :name,
      :capacity,
      :extended,
      rows: [],
      columns: [],
      not_available: [],
      seats: [],
    )
  end
end
