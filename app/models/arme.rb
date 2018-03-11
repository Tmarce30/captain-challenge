class Arme < ApplicationRecord
  has_many :joueurs

  validates :nom, presence: true
  validates :puissance, presence: true
end
