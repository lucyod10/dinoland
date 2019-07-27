class CreateMixtapesSongs < ActiveRecord::Migration[5.2]
  def change
    create_table :accessories_characters, :id => false do |t|
          t.integer :accessory_id
          t.integer :character_id
    end
  end
end
