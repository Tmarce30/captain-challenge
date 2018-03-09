class Personnage < ApplicationRecord

  has_many :joueurs
  has_many :combats, through: :joueurs

  validates :nom, uniqueness: true, presence: true
  validates :points_vie, presence: true
  validates :points_attaque, presence: true
  mount_uploader :photo, PhotoUploader

  validate :sum_equals_100

  def sum_equals_100
     if points_vie + points_attaque != 100
       errors.add(:base, 'La somme des points de caractéristique doit être égale à 100')
     end
  end
end
