class BoxesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_box, only: %i[ show edit update destroy ]

  # GET /boxes
  def index
    @boxes = current_user.boxes.order(created_at: :desc)
  end

  # GET /boxes/1
  def show
  end

  # GET /boxes/new
  def new
    @box = current_user.boxes.new
  end

  # GET /boxes/1/edit
  def edit
  end

  # POST /boxes
  def create
    @box = current_user.boxes.new(box_params)

    if @box.save
      redirect_to @box, notice: "Box creata correttamente."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /boxes/1
  def update
    if @box.update(box_params)
      redirect_to @box, notice: "Box aggiornata correttamente."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /boxes/1
  def destroy
    @box.destroy
    redirect_to boxes_url, notice: "Box eliminata.", status: :see_other
  end

  private

    def set_box
      @box = current_user.boxes.find(params[:id])
    end

    # ?? importante: permettiamo :image oltre ai campi base
    def box_params
      params.require(:box).permit(:code, :name, :location, :description, :image)
    end
end
