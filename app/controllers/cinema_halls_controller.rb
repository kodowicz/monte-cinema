# frozen_string_literal: true

class CinemaHallsController < ApplicationController
  before_action :set_cinema_hall, only: %i[show update destroy]

  # GET /cinema_halls
  def index
    # return only available cinema_halls? or add additional attribute
    # cinema_hall available? if there's no screening at pointed time range
    @cinema_halls = CinemaHall.all.map do |hall|
      render_cinema_hall(hall)
    end
    render json: @cinema_halls
  end

  # GET /cinema_halls/:id
  def show
    render json: @cinema_hall
  end

  # POST /cinema_halls/
  def create
    @cinema_hall = CinemaHall.create(cinema_hall_params)

    if @cinema_hall.save
      render json: @cinema_hall, status: :created
    else
      render json: @cinema_hall.errors, status: :unprocessable_entity
    end
  end

  # PUT /cinema_halls/:id
  def update
    if @cinema_hall.update(cinema_hall_params)
      render json: @cinema_hall, status: :ok
    else
      render json: @cinema_hall.errors, status: :unprocessable_entity
    end
  end

  # DELETE /cinema_halls/:id
  def destroy
    if @cinema_hall.destroy
      render json: @cinema_hall, status: :ok
    else
      render json: @cinema_hall.errors, status: :unprocessable_entity
    end
  end

  private

  def render_cinema_hall(cinema_hall)
    {
      id: cinema_hall.id,
      name: cinema_hall.name,
      capacity: cinema_hall.capacity
    }
  end

  def set_cinema_hall
    @cinema_hall = CinemaHall.find(params[:id])
  end

  def cinema_hall_params
    params.require(:cinema_hall).permit(:capacity, :name, :starts_at, :ends_at)
  end
end