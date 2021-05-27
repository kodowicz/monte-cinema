# frozen_string_literal: true

class MoviesController < ApplicationController
  # GET /movies
  def index
    movies = Movie.all

    render json: movies
  end

  # GET /movies/:id
  def show
    @movie = set_movie

    render json: @movie
  end

  # POST /movies
  def create
    movie = Movie.create(movie_params)

    if @movie.valid?
      render json: @movie, status: :created
    else
      render json: @movie.errors, status: :unprocessable_entity
    end
  end

  # DELETE /movies/:id
  def destroy
    @movie = set_movie

    if @movie.destroy
      render json: @movie, status: :ok
    else
      render json: @movie.errors, status: :unprocessable_entity
    end
  end

  private

  def set_movie
    @movie = Movie.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(:title, :genre)
  end
end
