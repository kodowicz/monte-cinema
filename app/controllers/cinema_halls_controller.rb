class CinemaHallsController < ApplicationController
  before_action :authenticate_user!

  def index
    cinema_halls = CinemaHalls::Repository.new.find_all

    if permit_params[:extended]
      render json: CinemaHalls::Representers::All.new(cinema_halls).extended
    else
      render json: CinemaHalls::Representers::All.new(cinema_halls).basic
    end
  end

  def show
    cinema_hall = CinemaHalls::Repository.new.find(params[:id])

    if permit_params[:extended]
      render json: CinemaHalls::Representers::Single.new(cinema_hall).extended
    else
      render json: CinemaHalls::Representers::Single.new(cinema_hall).basic
    end
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
    CinemaHalls::UseCases::Delete.new.call(id: params[:id])
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
      seats: []
    )
  end
end
