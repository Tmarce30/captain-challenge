class CombatsController < ApplicationController

  def new
    @combat = Combat.new
    2.times { @combat.joueurs.build}
  end

  def create
    @combat = Combat.new(combat_params)
    @combat.save
    byebug
  end

  private

  def combat_params
    params.require(:combat).permit(joueurs_attributes: [:combat_id, :personnage_id])
  end
end
