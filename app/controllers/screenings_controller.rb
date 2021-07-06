# frozen_string_literal: true

class ScreeningsController < ApplicationController
  def show
    screening = Screenings::Repository.new.find(params[:id])
    render json: { screening: Screenings::Representers::Single.new(screening).extended }
  end
end
