class CinemaHallsController < ApplicationController
  def index
    cinema_halls = CinemaHalls::Repository.new.find_all
    render json: CinemaHalls::Representers::All.new(cinema_halls).basic
  end

  def show
    cinema_hall = CinemaHalls::Repository.new.find(params[:id])
    render json: CinemaHalls::Representers::Single.new(cinema_hall).basic
  end

  def create
    cinema_hall = CinemaHalls::UseCases::Create.new.call(params: permit_params)

    if cinema_hall.valid?
      render json: CinemaHalls::Representers::Single.new(cinema_hall).basic, status: :created
    else
      render json: cinema_hall.errors, status: :unprocessable_entity
    end
  end

  def update
    cinema_hall = CinemaHalls::UseCases::Update.new.call(id: params[:id], params: permit_params)

    if cinema_hall.valid?
      render json: CinemaHalls::Representers::Single.new(cinema_hall).basic
    else
      render json: cinema_hall.errors, status: :unprocessable_entity
    end
  end

  def destroy
    cinema_hall = CinemaHalls::UseCases::Delete.new.call(id: params[:id])

    if cinema_hall.valid?
      render json: { message: "Hall #{cinema_hall.id} has been deleted successfuly" }
    else
      render json: cinema_hall.errors, status: :unprocessable_entity
    end
  end

  private

  def permit_params
    params.require(:cinema_hall).permit(:name, :capacity, rows: [], columns: [], not_available: [], seats: [])
  end
end
