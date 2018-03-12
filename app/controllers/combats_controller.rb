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
      deroulement_combat
      redirect_to combat_path(@combat)
    else
      render :new
    end
  end

  private

  def combat_params
    params.require(:combat).permit(joueurs_attributes: [:id, :personnage_id, :arme_id, :bouclier_id])
  end

  def deroulement_combat
    ordre_attaque
    rounds
    resultat
    @joueur_1.save
    @joueur_2.save
  end

  def ordre_attaque
    joueurs = @combat.joueurs
    @joueur_1 = joueurs.sample
    @joueur_2 = joueurs.reject { |joueur| joueur == @joueur_1 }.first
  end

  def rounds
    while @joueur_1.personnage.points_vie > 0
      coups(@joueur_1, @joueur_2)
      break if @joueur_2.personnage.points_vie <= 0
      coups(@joueur_2, @joueur_1)
    end
  end

  def coups(joueur_qui_attaque, joueur_qui_defend)
    puissance_joueur = joueur_qui_attaque.personnage.points_attaque + joueur_qui_attaque.arme.puissance
    if esquive?(joueur_qui_defend.personnage.points_agilite)
      joueur_qui_defend.increment(:coups_esquivés, by = 1)
    else
      if joueur_qui_defend.bouclier.protection > 0
        joueur_qui_defend.bouclier.protection -= (puissance_joueur / 10)
      else
        joueur_qui_defend.personnage.points_vie -= (puissance_joueur / 10)
      end
      joueur_qui_attaque.increment(:coups_donnés, by = 1)
    end
  end

  def esquive?(joueur_agilite)
    rand <= joueur_agilite / 100.0
  end

  def resultat
    if @joueur_1.personnage.points_vie <= 0
      @joueur_1.resultat = 'Perdant'
      @joueur_2.resultat = 'Vainqueur'
    elsif @joueur_2.personnage.points_vie <= 0
      @joueur_1.resultat = 'Vainqueur'
      @joueur_2.resultat = 'Perdant'
    end
  end
end
