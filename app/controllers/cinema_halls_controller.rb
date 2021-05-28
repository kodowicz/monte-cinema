# frozen_string_literal: true

class CinemaHallsController < ApplicationController
  # GET /cinema_halls
  def index
    cinema_halls = CinemaHalls::UseCases::FetchAll.new.call
    render json: CinemaHalls::Representers::All.new(cinema_halls).basic
  end

  # GET /cinema_halls/:id
  def show
    cinema_hall = CinemaHalls::UseCases::Find.new.call(id: params[:id])
    render json: CinemaHalls::Representers::Single.new(cinema_hall).basic, status: :ok
  end

  # POST /cinema_halls/
  def create
    cinema_hall = CinemaHalls::UseCases::Create.new.call(params: cinema_hall_params)

    if cinema_hall.valid?
      render json: CinemaHalls::Representers::Single.new(cinema_hall).basic, status: :created
    else
      render json: cinema_hall.errors, status: :unprocessable_entity
    end
  end

  # PUT /cinema_halls/:id
  def update
    cinema_hall = CinemaHalls::UseCases::Update.new.call(id: params[:id], params: cinema_hall_params)

    if cinema_hall.valid?
      render json: CinemaHalls::Representers::Single.new(cinema_hall).basic, status: :ok
    else
      render json: @cinema_hall.errors, status: :unprocessable_entity
    end
  end

  # DELETE /cinema_halls/:id
  def destroy
    cinema_hall = CinemaHalls::UseCases::Delete.new.call(id: params[:id])

    if cinema_hall.valid?
      render json: { message: "#{cinema_hall.name} has been deleted" }, status: :ok
    else
      render json: cinema_hall.errors, status: :unprocessable_entity
    end
  end

  private

  def cinema_hall_params
    params.require(:cinema_hall).permit(:capacity, :name)
  end
end
