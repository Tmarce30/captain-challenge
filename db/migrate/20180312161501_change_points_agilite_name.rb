class ChangePointsAgiliteName < ActiveRecord::Migration[5.0]
  def change
    rename_column :personnages, :points_agilité, :points_agilite
  end
end
