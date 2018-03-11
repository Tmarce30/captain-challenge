class Bouclier < ApplicationRecord
  has_many :joueurs

  validates :nom, presence: true
  validates :protection, presence: true
end
