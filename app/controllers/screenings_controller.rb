# frozen_string_literal: true

class ScreeningsController < ApplicationController
  def show
    screening = Screenings::Repository.new.find(params[:id])
    render json: { screening: Screenings::Representers::Single.new(screening).extended }
  end

  private

  def permit_params
    params.require(:screening).permit(:movie_id, :starts_at, :ends_at)
  end
end
