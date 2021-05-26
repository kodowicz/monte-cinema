# frozen_string_literal: true

class ScreeningsController < ApplicationController
  before_action :set_screening, only: %i[show update destroy]
  before_action :set_screenings, only: %i[index create]

  # GET /screenings
  def index
    @screenings.map do |screening|
      render_screening(screening)
    end
    render json: @screenings
  end

  # GET /screenings/:id
  def show
    render json: @screening
  end

  # POST /screenings/ body with movie_id
  def create
    @screening = @screenings.create(screening_params)

    if @screening.save
      render json: render_screening(@screening), status: :created
    else
      render json: @screening.errors, status: :unprocessable_entity
    end
  end

  # PUT /screenings/:id
  def update
    if @screening.update(screening_params)
      render json: render_screening(@screening), status: :ok
    else
      render json: @screening.errors, status: :unprocessable_entity
    end
  end

  # DELETE /screenings/:id
  def destroy
    if @screening.destroy
      render json: render_screening(@screening), status: :ok
    else
      render json: @screening.errors, status: :unprocessable_entity
    end
  end

  private

  def render_screening(screening)
    {
      id: screening.id,
      starts_at: screening.starts_at,
      ends_at: screening.ends_at
    }
  end

  def set_screenings
    @cinema_hall = CinemaHall.find(params[:cinema_hall_id])
    @screenings = @cinema_hall.screenings
  end

  def set_screening
    @screening = Screening.find(params[:id])
  end

  # improve to get starts_at and duration then create ends_at
  def screening_params
    params.require(:screening).permit(:movie_id, :starts_at, :ends_at)
  end
end