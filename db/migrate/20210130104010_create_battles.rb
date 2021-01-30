# frozen_string_literal: true

class CreateBattles < ActiveRecord::Migration[6.1]
  def change
    create_table :battles do |t|
      t.references :avatar1, { to_table: :avatars }
      t.references :avatar2, { to_table: :avatars }
      t.string :state
      t.datetime :end_at

      t.timestamps
    end
  end
end
