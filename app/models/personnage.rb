class Personnage < ApplicationRecord

  has_many :joueurs
  has_many :combats, through: :joueurs

  validates :nom, uniqueness: true, presence: true
  validates :points_vie, presence: true, inclusion: { in: 1..100 }
  validates :points_attaque, presence: true, inclusion: { in: 1..100 }
  validates :points_agilite, presence: true, inclusion: { in: 1..100 }
  validates :photo, presence: true
  mount_uploader :photo, PhotoUploader

  validate :sum_equals_150

  def sum_equals_150
    unless [points_vie, points_attaque, points_agilite].any? { |e| e.nil? }
     if points_vie + points_attaque + points_agilite != 150
       errors.add(:base, 'La somme des points de caractéristique doit être égale à 150')
     end
    end
  end
end
