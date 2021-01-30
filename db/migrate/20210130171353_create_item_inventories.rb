class CreateItemInventories < ActiveRecord::Migration[6.1]
  def change
    create_table :item_inventories do |t|
      t.references :avatar
      t.references :item

      t.timestamps
    end
  end
end
