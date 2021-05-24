# frozen_string_literal: true

class TicketDesksController < ApplicationController
  before_action :set_ticket_desk, only: %i[show update destroy]

  # GET /ticket_desks
  def index
    @ticket_desks = TicketDesk.all.map do |desk|
      render_ticket_desk(desk)
    end
    render json: @ticket_desks
  end

  # GET /ticket_desks/:ticket_desk_id
  def show
    render json: render_ticket_desk(@ticket_desk)
  end

  # POST /ticket_desks/
  def create
    @ticket_desk = TicketDesk.create(ticket_desk_params)

    if @ticket_desk.save
      render json: @ticket_desk, status: :created, location: @ticket_desk
    else
      render json: @ticket_desk.errors, status: :unprocessable_entity
    end
  end

  # PUT /ticket_desks/:ticket_desk_id
  def update
    if @ticket_desk.update!(ticket_desk_params)
      render json: @ticket_desk, status: :ok
    else
      render json: @ticket_desk.errors, status: :unprocessable_entity
    end
  end

  # DELETE /ticket_desks/:ticket_desk_id
  def destroy
    if @ticket_desk.destroy!
      render json: @ticket_desk, status: :ok
    else
      render json: @ticket_desk.errors, status: :unprocessable_entity
    end
  end

  private

  def render_ticket_desk(ticket_desk)
    {
      id: ticket_desk.id,
      name: ticket_desk.name,
      type: ticket_desk.type
    }
  end

  def set_ticket_desk
    @ticket_desk = TicketDesk.find(params[:id])
  end

  def ticket_desk_params
    params.require(:ticket_desk).permit(:type, :name)
  end
end