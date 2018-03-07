class CreatePersonnages < ActiveRecord::Migration[5.0]
  def change
    create_table :personnages do |t|
      t.string :nom
      t.integer :points_vie
      t.integer :points_attaque

      t.timestamps
    end
  end
end
