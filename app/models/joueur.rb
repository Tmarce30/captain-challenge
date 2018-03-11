class Joueur < ApplicationRecord
  belongs_to :personnage
  belongs_to :combat, required: false
  belongs_to :bouclier
  belongs_to :arme
end
