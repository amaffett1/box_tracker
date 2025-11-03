class MovementsController < ApplicationController
  before_action :authenticate_user!

  def index
    @movements = current_user.movements
                             .includes(:item, :from_box, :to_box)
                             .order(created_at: :desc)
    @movements_chart = current_user.movements.group("DATE(created_at)").count

    # Filtri opzionali
    @movements = @movements.where(action: params[:action_type]) if params[:action_type].present?
    @movements = @movements.where(from_box_id: params[:from_box_id]) if params[:from_box_id].present?
    @movements = @movements.where(to_box_id: params[:to_box_id]) if params[:to_box_id].present?
  end

  def create
    @movement = current_user.movements.new(movement_params)
    if @movement.save
      redirect_to @movement.item, notice: "Movimento registrato correttamente."
    else
      redirect_to @movement.item, alert: "Errore durante la registrazione del movimento."
    end
  end

  private

  def movement_params
    params.require(:movement).permit(:item_id, :action, :from_box_id, :to_box_id, :notes)
  end
end
