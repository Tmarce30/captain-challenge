class CreateCombats < ActiveRecord::Migration[5.0]
  def change
    create_table :combats do |t|

      t.timestamps
    end
  end
end
