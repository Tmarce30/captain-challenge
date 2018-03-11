class Joueur < ApplicationRecord
  belongs_to :personnage
  belongs_to :combat, required: false
  belongs_to :bouclier
  belongs_to :arme

  validates :personnage_id, presence: true
  validates :bouclier_id, presence: true
  validates :arme_id, presence: true
end
