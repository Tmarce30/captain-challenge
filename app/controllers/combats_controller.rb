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

  def coups(joueur_qui_attaque, joueur_qui_défend)
    if esquive?(joueur_qui_défend.personnage.points_agilité)
      joueur_qui_défend.increment(:coups_esquivés, by = 1)
    else
      joueur_qui_défend.personnage.points_vie -= (joueur_qui_attaque.personnage.points_attaque / 10)
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
