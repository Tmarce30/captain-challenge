class Personnage < ApplicationRecord
  validates :nom, uniqueness: true, presence: true
  validates :points_vie, presence: true
  validates :points_attaque, presence: true

  validate :sum_equals_100

  def sum_equals_100
     if points_vie + points_attaque != 100
       errors.add(:base, 'La somme des points de caractéristique doit être égale à 100')
     end
  end
end
