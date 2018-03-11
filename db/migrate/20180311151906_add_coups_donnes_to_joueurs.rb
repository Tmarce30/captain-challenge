class AddCoupsDonnesToJoueurs < ActiveRecord::Migration[5.0]
  def change
    add_column :joueurs, :coups_donnés, :integer
  end
end
