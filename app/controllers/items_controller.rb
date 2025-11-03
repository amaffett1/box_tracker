# encoding: utf-8

class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: %i[ show edit update destroy ]

  # GET /items
  def index
    # Mostra solo gli item delle box dell�utente loggato
    @items = Item.joins(:box).where(boxes: { user_id: current_user.id }).order(created_at: :desc)
  end

  # GET /items/1
  def show
    authorize_item!
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
    authorize_item!
  end

  # POST /items
  def create
    @item = Item.new(item_params)
    authorize_item!

    if @item.save
      redirect_to @item, notice: "Oggetto creato correttamente."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /items/1
  def update
    authorize_item!
    if @item.update(item_params)
      redirect_to @item, notice: "Oggetto aggiornato correttamente."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /items/1
  def destroy
    authorize_item!
    @item.destroy
    redirect_to items_url, notice: "Oggetto eliminato.", status: :see_other
  end

  private
    def set_item
      @item = Item.find(params[:id])
    end

    # ?? permettiamo :image oltre ai campi base
    def item_params
      params.require(:item).permit(:box_id, :name, :category, :quantity, :position, :notes, :image)
    end

    # Utente pu� agire solo sugli item delle proprie box
    def authorize_item!
      unless @item.box.user_id == current_user.id
        redirect_to items_path, alert: "Non autorizzato"
      end
      def show
      @item = Item.find(params[:id])
      @movements = @item.movements.order(created_at: :desc)
      end
    end
end
