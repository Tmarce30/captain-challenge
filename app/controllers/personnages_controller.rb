class PersonnagesController < ApplicationController
  before_action :set_personnage, only: [:show, :edit]
  def index
    @personnages = Personnage.all
  end

  def show
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

  private

  def personnage_params
    params.require(:personnage).permit(:nom, :points_vie, :points_attaque)
  end

  def set_personnage
    @personnage = Personnage.find(params[:id])
  end
end
