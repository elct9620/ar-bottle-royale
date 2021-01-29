# frozen_string_literal: true

class CreateAvatars < ActiveRecord::Migration[6.1]
  def change
    create_table :avatars do |t|
      t.references :user
      t.string :name, null: false
      t.integer :hp, default: 10
      t.integer :max_hp, default: 10

      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
