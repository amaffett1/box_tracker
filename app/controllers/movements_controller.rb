# encoding: utf-8

class MovementsController < ApplicationController
  before_action :authenticate_user!

  def create
    @movement = Movement.new(movement_params)
    @movement.user = current_user

    # Imposta la box di partenza (quella attuale dell’oggetto)
    @movement.from_box = @movement.item.box

    if @movement.save
      # Se è stato selezionato un box di destinazione, aggiorna l'oggetto
      if @movement.to_box.present?
        @movement.item.update(box: @movement.to_box)
      end
      redirect_to item_path(@movement.item), notice: "Movimento registrato correttamente."
    else
      redirect_to item_path(@movement.item), alert: "Errore nella registrazione del movimento."
    end
  end

  private

  def movement_params
    params.require(:movement).permit(:item_id, :action, :to_box_id, :notes)
  end
end
