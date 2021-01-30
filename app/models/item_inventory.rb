# == Schema Information
#
# Table name: item_inventories
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  avatar_id  :bigint
#  item_id    :bigint
#
# Indexes
#
#  index_item_inventories_on_avatar_id  (avatar_id)
#  index_item_inventories_on_item_id    (item_id)
#
class ItemInventory < ApplicationRecord
  belongs_to :avatar
  belongs_to :item

  after_commit :notify_inventory_changed

  private

  def notify_inventory_changed
    PlayerChannel
      .broadcast_to(
        avatar.user,
        action: 'inventory:changed',
        payload: {
          inventories: avatar
            .item_inventories.includes(:item).as_json(include: :item)
        }
      )
  end
end
