# frozen_string_literal: true

class MoviesController < ApplicationController
  def index
      movies = Movies::Repository.new.find_by(
        filter: 'title LIKE ?',
        params: "%#{search_params[:input]}%"
      )
      movies << Movies::Repository.new.find_by(
        filter: 'description LIKE ?',
        params: "%#{search_params[:input]}%"
      )
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

  def permit_params
    params.require(:movie).permit(:title, :genre)
  end

  def popular_params
    params.require(:movie).permit(:limit, :extended)
  end
end
