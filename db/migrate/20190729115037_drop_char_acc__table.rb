class DropCharAccTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :characters_accessories do |t|
      t.integer :accessory_id, null: false
      t.integer :character_id, null: false
    end
  end
end
