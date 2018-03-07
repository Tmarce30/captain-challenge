class Personnage < ApplicationRecord
  validates :nom, uniqueness: true, presence: true
  validates :points_vie, uniqueness: true, presence: true
  validates :points_attaque, uniqueness: true, presence: true
end
