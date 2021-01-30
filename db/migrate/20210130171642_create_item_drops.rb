class CreateItemDrops < ActiveRecord::Migration[6.1]
  def change
    create_table :item_drops do |t|
      t.string :category, index: true
      t.references :item
      t.integer :weight

      t.timestamps
    end
  end
end
