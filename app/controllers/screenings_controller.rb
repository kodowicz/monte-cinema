# frozen_string_literal: true

class ScreeningsController < ApplicationController
  # GET /screenings
  def index
    @screenings = set_screenings
    
    @screenings.map do |screening|
      render_screening(screening)
    end
    render json: @screenings
  end

  # GET /screenings/:id
  def show
    @screening = set_screening

    render json: render_screening(@screening)
  end

  # POST /screenings/
  def create
    @screenings = set_screenings
    screening = @screenings.create(screening_params)

    if @screening.valid?
      render json: render_screening(screening), status: :created
    else
      render json: screening.errors, status: :unprocessable_entity
    end
  end

  # PUT /screenings/:id
  def update
    @screening = set_screening

    if @screening.update(screening_params)
      render json: render_screening(@screening), status: :ok
    else
      render json: @screening.errors, status: :unprocessable_entity
    end
  end

  # DELETE /screenings/:id
  def destroy
    @screening = set_screening

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

  def screening_params
    params.require(:screening).permit(:movie_id, :starts_at, :ends_at)
  end
end
