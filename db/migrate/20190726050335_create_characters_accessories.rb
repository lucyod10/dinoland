class CreateCharactersAccessories < ActiveRecord::Migration[5.2]
  def change
    create_table :characters_accessories, :id => false do |t|
      t.integer :character_id
      t.integer :accessory_id
    end
  end
end
