class Joueur < ApplicationRecord
  belongs_to :personnage
  belongs_to :combat, required: false
  belongs_to :bouclier
  belongs_to :arme

  validate :personnage_id, presence: true
  validate :bouclier_id, presence: true
  validate :arme_id, presence: true
end
