class CinemaHallsController < ApplicationController
  def index
    cinema_halls = CinemaHalls::UseCases::FetchAll.new.call
    render json: CinemaHalls::Representers::All.new(cinema_halls).basic
  end

  def show
    cinema_hall = CinemaHalls::UseCases::Find.new.call(id: params[:id])
    render json: CinemaHalls::Representers::Single.new(cinema_hall).basic
  end
  
  def create
    cinema_hall = CinemaHalls::UseCases::Create.new.call(params: cinema_hall_params)

    if cinema_hall.valid?
      render json: CinemaHalls::Representers::Single.new(cinema_hall).basic, status: :created, location: cinema_hall
    else
      render json: cinema_hall.errors, status: :unprocessable_entity
    end
  end

  def update
    cinema_hall = CinemaHalls::UseCases::Update.new.call(id: params[:id], params: cinema_hall_params)
    
    if cinema_hall.valid?
      render json: CinemaHalls::Representers::Single.new(cinema_hall).basic
    else
      render json: cinema_hall.errors, status: :unprocessable_entity
    end
  end

  def destroy
    cinema_hall = CinemaHalls::UseCases::Delete.new.call(id: params[:id])

    if cinema_hall.valid?
      render json: CinemaHalls::Representers::Single.new(cinema_hall).basic
    else
      render json: cinema_hall.errors, status: :unprocessable_entity
    end
  end

  private

  def cinema_hall_params
    params.require(:cinema_hall).permit(:name, :capacity)
  end
end
