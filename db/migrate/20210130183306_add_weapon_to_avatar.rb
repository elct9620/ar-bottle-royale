class AddWeaponToAvatar < ActiveRecord::Migration[6.1]
  def change
    change_table :avatars, bulk: true do |t|
      t.references :weapon, to_table: :item
      t.references :armor, to_table: :item

      reversible do |dir|
        dir.up do
          t.change :hp, :integer, default: 100
          t.change :max_hp, :integer, default: 100
        end

        dir.down do
          t.change :hp, :integer, default: 10
          t.change :max_hp, :integer, default: 10
        end
      end
    end
  end
end
