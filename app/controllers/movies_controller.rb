# frozen_string_literal: true

class MoviesController < ApplicationController
  def index
    movies = Movies::Repository.new.find_by(
      filter: 'title LIKE ?',
      params: "%#{permit_params[:title]}%"
    )
    render json: Movies::Representers::All.new(movies).extended
  end

  def show
    movie = Movies::Repository.new.find(params[:id])
    render json: Movies::Representers::Single.new(movie).extended
  end

  private

  def permit_params
    params.require(:movie).permit(:title, :genre)
  end
end
