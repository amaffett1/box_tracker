class MovementsController < ApplicationController
  before_action :authenticate_user!

  def index
    @movements = current_user.movements
                             .includes(:item, :from_box, :to_box, :user)
                             .order(created_at: :desc)

    # Serie per chart (compatibile con Postgres)
    @series = Movement
                .joins(:user)
                .where(users: { id: current_user.id })
                .group("DATE(movements.created_at)")
                .order("DATE(movements.created_at)")
                .count
  end
end
