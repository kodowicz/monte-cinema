# frozen_string_literal: true

class MoviesController < ApplicationController
  # GET /movies
  def index
    movies = Movie.where('title LIKE ?', "%#{movie_params[:title]}%")
    render json: movies, status: :ok
  end

  # GET /movies/:id
  def show
    render json: movie, status: :ok
  end

  # POST /movies
  def create
    movie = Movie.create(movie_params)

    if movie.save
      render json: movie, status: :created
    else
      render json: movie.errors, status: :unprocessable_entity
    end
  end

  # DELETE /movies/:id
  def destroy
    if movie.destroy
      render json: movie, status: :ok
    else
      render json: movie.errors, status: :unprocessable_entity
    end
  end

  private
  
  def movie
    movie ||= Movie.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(:title, :genre)
  end
end
