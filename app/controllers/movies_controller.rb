# frozen_string_literal: true

class MoviesController < ApplicationController
  rescue_from Movies::Validators::OrderValidator::ValidationError, with: :invalid_order
  rescue_from Movies::Validators::PaginationValidator::ValidationError, with: :invalid_pagination

  def index
    movies = Movies::UseCases::FindOrder.new(params: movies_params).call

    if movies_params[:extended]
      render json:
        Movies::Representers::Pagination
          .new(movies: movies, pagination: movies_params[:pagination])
          .extended
    else
      render json:
        Movies::Representers::Pagination
          .new(movies: movies, pagination: movies_params[:pagination])
          .basic
    end
  end

  def popular
    movies = Movies::UseCases::FindPopular.new(params: popular_params).call

    if movies_params[:extended]
      render json:
        Movies::Representers::Pagination
          .new(movies: movies, pagination: popular_params[:pagination])
          .extended
    else
      render json:
        Movies::Representers::Pagination
          .new(movies: movies, pagination: popular_params[:pagination])
          .basic
    end
  end

  def search
    movies = Movies::UseCases::Search.new(params: search_params).call

    if movies_params[:extended]
      render json:
        Movies::Representers::Pagination
          .new(movies: movies, pagination: popular_params[:pagination])
          .extended
    else
      render json:
        Movies::Representers::Pagination
          .new(movies: movies, pagination: popular_params[:pagination])
          .basic
    end
  end

  def show
    movie = Movies::Repository.new.find(params[:id])
    render json: { movie: Movies::Representers::Single.new(movie).extended }
  end

  private

  def invalid_pagination(error)
    render json: { error: "invalid pagination", details: error }.to_json, status: :unprocessable_entity
  end

  def invalid_order(error)
    render json: { error: "invalid  order", details: error }.to_json, status: :unprocessable_entity
  end

  def movies_params
    params.require(:movie).permit(:extended, :order, pagination: %i(page items))
  end

  def popular_params
    params.require(:movie).permit(:ratio, :extended, pagination: %i(page items))
  end

  def search_params
    params.require(:movie).permit(
      :extended,
      :search,
      pagination: %i(page items),
      filter: %i(genre_id display_type_id voice_type_id),
    )
  end
end
