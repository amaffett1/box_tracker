class MovementsController < ApplicationController
  before_action :authenticate_user!

  def index
    @movements = Movement.joins(:item).where(items: { box_id: current_user.boxes.pluck(:id) }).order(created_at: :desc)
  end

  def create
    @movement = Movement.new(movement_params)
    @movement.user = current_user

    if @movement.save
      redirect_to @movement.item, notice: "Movimento registrato."
    else
      redirect_back fallback_location: root_path, alert: "Errore nel salvataggio del movimento."
    end
  end

  private

  def movement_params
    params.require(:movement).permit(:item_id, :action, :from_box_id, :to_box_id, :notes)
  end
end
