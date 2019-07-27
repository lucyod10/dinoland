class CreateSpecies < ActiveRecord::Migration[5.2]
  def change
    create_table :species do |t|
      t.text :genus
      t.text :order
      t.text :diet
      t.text :image
      t.text :fun_fact

      t.timestamps
    end
  end
end
