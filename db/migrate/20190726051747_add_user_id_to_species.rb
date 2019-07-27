class AddUserIdToSpecies < ActiveRecord::Migration[5.2]
  def change
    add_column :species, :user_id, :integer
  end
end
