class ChangePosessionColName < ActiveRecord::Migration[5.2]
  def change
    rename_column :posessions, :species_id, :character_id
  end
end
