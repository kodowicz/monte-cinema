# frozen_string_literal: true

class ScreeningsController < ApplicationController
  # GET /screenings
  def index
    screenings = Movie.find(params[:movie_id]).screenings

    screenings.map do |screening|
      render_screening(screening)
    end
    render json: screenings, status: :ok
  end

  # GET /screenings/:id
  def show
    render json: screening, status: :ok
  end

  # POST /screenings/ body with movie_id
  def create
    screening = screenings.create(screening_params)

    if screening.save
      render json: render_screening(screening), status: :created
    else
      render json: screening.errors, status: :unprocessable_entity
    end
  end

  # PUT /screenings/:id
  def update
    if screening.update(screening_params)
      render json: render_screening(screening), status: :ok
    else
      render json: screening.errors, status: :unprocessable_entity
    end
  end

  # DELETE /screenings/:id
  def destroy
    if screening.destroy
      render json: render_screening(screening), status: :ok
    else
      render json: screening.errors, status: :unprocessable_entity
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

  def screenings
    cinema_hall ||= CinemaHall.find(params[:cinema_hall_id])
    screenings ||= cinema_hall.screenings
  end

  def screening
    screening ||= Screening.find(params[:id])
  end

  def screening_params
    params.require(:screening).permit(:movie_id, :starts_at, :ends_at)
  end
end