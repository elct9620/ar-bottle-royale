# frozen_string_literal: true

class CreateActions < ActiveRecord::Migration[6.1]
  def change
    create_table :actions do |t|
      t.references :battle
      t.references :avatar
      t.string :action
      t.integer :amount

      t.timestamps
    end
  end
end
