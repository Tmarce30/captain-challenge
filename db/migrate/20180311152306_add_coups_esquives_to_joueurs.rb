class AddCoupsEsquivesToJoueurs < ActiveRecord::Migration[5.0]
  def change
    add_column :joueurs, :coups_esquivés, :integer
  end
end
