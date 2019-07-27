class CreateAccessories < ActiveRecord::Migration[5.2]
  def change
    create_table :accessories do |t|
      t.text :name
      t.text :image
      t.float :cost

      t.timestamps
    end
  end
end
