class AddSpeciesIdToCharacters < ActiveRecord::Migration[5.2]
  def change
    add_column :characters, :species_id, :integer
  end
end
