class CombatsController < ApplicationController

  def show
    @combat = Combat.find(params[:id])
  end

  def new
    @combat = Combat.new
    2.times { @combat.joueurs.build}
  end

  def create
    @combat = Combat.new(combat_params)
    if @combat.save
      redirect_to combat_path(@combat)
    else
      render :new
    end
  end

  private

  def combat_params
    params.require(:combat).permit(joueurs_attributes: [:id, :personnage_id])
  end
end
