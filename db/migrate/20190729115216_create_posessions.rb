class CreatePosessions < ActiveRecord::Migration[5.2]
  def change
    create_table :posessions do |t|
      t.integer :accessory_id
      t.integer :species_id
      t.float :x_pos
      t.float :y_pos
      t.timestamps
    end
  end
end
