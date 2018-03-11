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
      deroulement_combat(@combat)
      redirect_to combat_path(@combat)
    else
      render :new
    end
  end

  private

  def combat_params
    params.require(:combat).permit(joueurs_attributes: [:id, :personnage_id])
  end

  def deroulement_combat(combat)
    joueurs = ordre_attaque(combat)

    joueur_1_vie = joueurs[:joueur_1].personnage.points_vie
    joueur_2_vie = joueurs[:joueur_2].personnage.points_vie

    while joueur_1_vie > 0
      joueur_2_vie -= (joueurs[:joueur_1].personnage.points_attaque / 10)
      break if joueur_2_vie <= 0
      joueur_1_vie -= (joueurs[:joueur_2].personnage.points_attaque / 10)
    end
  end

  def ordre_attaque(combat)
    joueurs = combat.joueurs
    joueur_1 = joueurs.sample
    joueur_2 = joueurs.reject { |joueur| joueur == joueur_1 }
    return { joueur_1: joueur_1, joueur_2: joueur_2.first }
  end
end
