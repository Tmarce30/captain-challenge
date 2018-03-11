class AddResultatToJoueurs < ActiveRecord::Migration[5.0]
  def change
    add_column :joueurs, :resultat, :string
  end
end
