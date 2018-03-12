class PersonnagesController < ApplicationController
  before_action :set_personnage, only: [:show, :edit, :update, :destroy]

  def index
    @personnages = Personnage.all
  end

  def show
    @combats = @personnage.combats
    @taux_de_victoire = taux_de_victoire
  end

  def new
    @personnage = Personnage.new
  end

  def create
    @personnage = Personnage.new(personnage_params)
    if @personnage.save
      redirect_to personnage_path(@personnage)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @personnage.update(personnage_params)
      redirect_to personnage_path(@personnage)
    else
      render :edit
    end
  end

  def destroy
    @personnage.destroy
    redirect_to personnages_path
  end

  private

  def personnage_params
    params.require(:personnage).permit(:nom, :points_vie, :points_attaque, :points_agilite, :photo)
  end

  def set_personnage
    @personnage = Personnage.find(params[:id])
  end

  def taux_de_victoire
    joueurs = @combats.map { |combat| combat.joueurs }
    resultats = []
    joueurs.flatten.each do |joueur|
      resultats << joueur if joueur.personnage_id == @personnage.id
    end
    victoires = []
    resultats.each do |joueur|
      victoires << joueur if joueur.resultat == 'Vainqueur'
    end
    return (victoires.length / resultats.length) * 100 unless resultats.length == 0
  end
end
