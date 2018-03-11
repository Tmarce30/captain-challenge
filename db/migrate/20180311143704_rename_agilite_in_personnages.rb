class RenameAgiliteInPersonnages < ActiveRecord::Migration[5.0]
  def change
    rename_column :personnages, :agilité, :points_agilité
  end
end
