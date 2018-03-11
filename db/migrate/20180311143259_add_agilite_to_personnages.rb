class AddAgiliteToPersonnages < ActiveRecord::Migration[5.0]
  def change
    add_column :personnages, :agilité, :integer
  end
end
