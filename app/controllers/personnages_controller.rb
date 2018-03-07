class PersonnagesController < ApplicationController
  def index
    @personnages = Personnage.all
  end
end
