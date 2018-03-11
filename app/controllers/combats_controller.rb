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
      if esquive?(joueurs[:joueur_2].personnage.points_agilité)
        joueurs[:joueur_2].increment(:coups_esquivés, by = 1)
        joueurs[:joueur_2].save
      else
        joueur_2_vie -= (joueurs[:joueur_1].personnage.points_attaque / 10)
        joueurs[:joueur_1].increment(:coups_donnés, by = 1)
        joueurs[:joueur_1].save
      end

      break if joueur_2_vie <= 0

      if esquive?(joueurs[:joueur_1].personnage.points_agilité)
        joueurs[:joueur_1].increment(:coups_esquivés, by = 1)
        joueurs[:joueur_1].save
      else
        joueur_1_vie -= (joueurs[:joueur_2].personnage.points_attaque / 10)
        joueurs[:joueur_2].increment(:coups_donnés, by = 1)
        joueurs[:joueur_2].save
      end
    end

    resultat(joueurs, joueur_1_vie, joueur_2_vie)
  end

  def ordre_attaque(combat)
    joueurs = combat.joueurs
    joueur_1 = joueurs.sample
    joueur_2 = joueurs.reject { |joueur| joueur == joueur_1 }
    return { joueur_1: joueur_1, joueur_2: joueur_2.first }
  end

  def resultat(joueurs, joueur_1_vie, joueur_2_vie)
    if joueur_1_vie <= 0
      joueurs[:joueur_1].resultat = 'Perdant'
      joueurs[:joueur_2].resultat = 'Vainqueur'
    elsif joueur_2_vie <= 0
      joueurs[:joueur_1].resultat = 'Vainqueur'
      joueurs[:joueur_2].resultat = 'Perdant'
    end
    joueurs[:joueur_1].save
    joueurs[:joueur_2].save
  end

  def esquive?(joueur_agilite)
    rand <= joueur_agilite / 100.0
  end
end
