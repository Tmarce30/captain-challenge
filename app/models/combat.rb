class Combat < ApplicationRecord
  has_many :joueurs
  has_many :personnages, through: :joueurs
end
