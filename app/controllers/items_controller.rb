# encoding: utf-8

class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_box, only: %i[index new create]
  before_action :set_item, only: %i[show edit update destroy]
  before_action :authorize_item!, only: %i[show edit update destroy]

  # GET /boxes/:box_id/items
  # oppure /items (tutti gli item dell’utente)
  def index
    # Se è stata richiesta una box specifica (es. /boxes/3/items)
    @box = Box.find(params[:box_id]) if params[:box_id]

    if @box
      # Mostra solo gli item di quella box
      @items = @box.items.order(created_at: :desc)
    else
      # Altrimenti mostra tutti gli item dell'utente loggato
      @items = Item.joins(:box)
                   .where(boxes: { user_id: current_user.id })
                   .order(created_at: :desc)
    end
  end

  # GET /items/:id
  def show
    @movements = @item.movements.includes(:from_box, :to_box, :user).order(created_at: :desc)
  end

  # GET /boxes/:box_id/items/new
  def new
    @item = @box.items.new
  end

  # GET /items/:id/edit
  def edit; end

  # POST /boxes/:box_id/items
  def create
    @box = Box.find(params[:box_id])
    @item = @box.items.new(item_params)
    if @item.save
      redirect_to box_items_path(@box), notice: "Oggetto creato correttamente."
    else
      render :new, status: :unprocessable_entity
    end
  end


  # PATCH/PUT /items/:id
  def update
    if @item.update(item_params)
      redirect_to @item, notice: "Oggetto aggiornato correttamente."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /items/:id
  def destroy
    @item.destroy
    redirect_to items_url, notice: "Oggetto eliminato.", status: :see_other
  end

  private

    # Carica box se presente nel path
    def set_box
      @box = Box.find(params[:box_id]) if params[:box_id]
    end

    def set_item
      @item = Item.find(params[:id])
    end

    def item_params
      params.require(:item).permit(:box_id, :name, :category, :quantity, :position, :notes, :description, images: [])
    end

    def authorize_item!
      unless @item.box.user_id == current_user.id
        redirect_to items_path, alert: "Non autorizzato"
      end
    end
end
