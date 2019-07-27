class CreateCharacters < ActiveRecord::Migration[5.2]
  def change
    create_table :characters do |t|
      t.text :name
      t.integer :age
      t.text :talent

      t.timestamps
    end
  end
end
