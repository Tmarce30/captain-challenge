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
      deroulement_combat
      redirect_to combat_path(@combat)
    else
      render :new
    end
  end

  private

  def combat_params
    params.require(:combat).permit(joueurs_attributes: [:id, :personnage_id])
  end

  def deroulement_combat
    joueurs = ordre_attaque
    @joueur_1 = joueurs[:joueur_1]
    @joueur_2 = joueurs[:joueur_2]

    @joueur_1_vie = @joueur_1.personnage.points_vie
    @joueur_2_vie = @joueur_2.personnage.points_vie

    while @joueur_1_vie > 0
      if esquive?(@joueur_2.personnage.points_agilité)
        @joueur_2.increment(:coups_esquivés, by = 1)
        @joueur_2.save
      else
        @joueur_2_vie -= (@joueur_1.personnage.points_attaque / 10)
        @joueur_1.increment(:coups_donnés, by = 1)
        @joueur_1.save
      end

      break if @joueur_2_vie <= 0

      if esquive?(@joueur_1.personnage.points_agilité)
        @joueur_1.increment(:coups_esquivés, by = 1)
        @joueur_1.save
      else
        @joueur_1_vie -= (@joueur_2.personnage.points_attaque / 10)
        @joueur_2.increment(:coups_donnés, by = 1)
        @joueur_2.save
      end
    end

    resultat
  end

  def ordre_attaque
    joueurs = @combat.joueurs
    joueur_1 = joueurs.sample
    joueur_2 = joueurs.reject { |joueur| joueur == joueur_1 }
    return { joueur_1: joueur_1, joueur_2: joueur_2.first }
  end

  def resultat
    if @joueur_1_vie <= 0
      @joueur_1.resultat = 'Perdant'
      @joueur_2.resultat = 'Vainqueur'
    elsif @joueur_2_vie <= 0
      @joueur_1.resultat = 'Vainqueur'
      @joueur_2.resultat = 'Perdant'
    end
    @joueur_1.save
    @joueur_2.save
  end

  def esquive?(joueur_agilite)
    rand <= joueur_agilite / 100.0
  end
end
