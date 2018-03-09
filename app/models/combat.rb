class Combat < ApplicationRecord
  has_many :joueurs
  has_many :personnages, through: :joueurs

  accepts_nested_attributes_for :joueurs
end
