class CreateJoueurs < ActiveRecord::Migration[5.0]
  def change
    create_table :joueurs do |t|
      t.references :personnage, foreign_key: true
      t.references :combat, foreign_key: true

      t.timestamps
    end
  end
end
