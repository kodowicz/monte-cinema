# frozen_string_literal: true

class CinemaHallsController < ApplicationController
  before_action :set_cinema_hall, only: %i[show update destroy]

  # GET /cinema_halls
  def index
    @cinema_halls = CinemaHall.all.map do |hall|
      render_cinema_hall(hall)
    end
    render json: @cinema_halls
  end
  
  def show  
    render json: @cinema_hall
  end
  
  def create
    @cinema_hall = Hall.create(hall_params)

    if @cinema_hall.save
      render json: @cinema_hall, status: :created, location: @cinema_hall
    else
      render json: @cinema_hall.errors, status: :unprocessable_entity
    end
  end
  
  def update
    if @cinema_hall.update(cinema_hall_params)
      render json: @cinema_hall, status: :ok
    else 
      render json: @cinema_hall.errors, status: :unprocessable_entity
    end
  end
  
  def destroy
    @cinema_hall.destroy
    redirect_to root_url, notice: 'Cinema hall has been deleted.'
  end

  private
  def render_cinema_hall(cinema_hall)
    {
      id: cinema_hall.id,
      hall_name: cinema_hall.hall_name,
      hall_size: cinema_hall.hall_size
    }
  end

  def set_cinema_hall
    @cinema_hall = CinemaHall.find(params[:id])
  end

  def cinema_hall_params
    params.require(:cinema_hall).permit(:hall_name, :hall_size)
  end
end

