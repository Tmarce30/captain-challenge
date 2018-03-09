class Joueur < ApplicationRecord
  belongs_to :personnage
  belongs_to :combat
end
