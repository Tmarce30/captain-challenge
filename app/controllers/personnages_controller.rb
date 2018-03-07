class PersonnagesController < ApplicationController
  before_action :set_personnage, only: [:show]
  def index
    @personnages = Personnage.all
  end

  def show
  end

  private

  def set_personnage
    @personnage = Personnage.find(params[:id])
  end
end
