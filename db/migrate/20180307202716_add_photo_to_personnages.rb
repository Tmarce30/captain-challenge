class AddPhotoToPersonnages < ActiveRecord::Migration[5.0]
  def change
    add_column :personnages, :photo, :string
  end
end
