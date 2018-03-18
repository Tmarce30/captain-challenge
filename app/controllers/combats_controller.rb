class CombatsController < ApplicationController

  def show
    @combat = Combat.find(params[:id])
  end

  def index
    @combats = Combat.all.last(10)
  end

  def new
    @combat = Combat.new
    2.times { @combat.joueurs.build}
  end

  def create
    @combat = Combat.new(combat_params)
    if @combat.save
      CombatService.new(combat: @combat).deroulement_combat
      redirect_to combat_path(@combat)
    else
      render :new
    end
  end

  private

  def combat_params
    params.require(:combat).permit(joueurs_attributes: [:id, :personnage_id, :arme_id, :bouclier_id])
  end
end
