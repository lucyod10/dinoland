class AddUserIdToAccessories < ActiveRecord::Migration[5.2]
  def change
    add_column :accessories, :user_id, :integer
  end
end
