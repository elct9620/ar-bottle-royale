class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :name
      t.string :icon_name
      t.string :asset_name
      t.string :type
      t.integer :value

      t.index %i[type id]

      t.timestamps
    end
  end
end
