# frozen_string_literal: true

class MoviesController < ApplicationController
  def index
    movies = Movies::Repository.new.find_order(order: movies_params[:order])

    render json: Movies::Representers::Pagination.new(
      movies: movies,
      pagination: params[:pagination]
    ).basic
  rescue Movies::Repository::InvalidParamsError => e
    render json: { error: e.message }.to_json, status: :unprocessable_entity
  end

  def popular
    movies = Movies::Repository.new.find_popular(limit: popular_params[:limit])

    if movies_params[:extended]
      render json: Movies::Representers::All.new(movies).extended
    else
      render json: Movies::Representers::All.new(movies).basic
    end
  end

  def show
    movie = Movies::Repository.new.find(params[:id])
    render json: Movies::Representers::Single.new(movie).extended
  end

  private

  def movies_params
    params.require(:movie).permit(:order, pagination: %i[page items])
  end

  def popular_params
    params.require(:movie).permit(:limit, :extended)
  end
end
