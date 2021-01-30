# frozen_string_literal: true

class CollectItemService
  attr_reader :avatar, :items

  def initialize(avatar, items)
    @avatar = avatar
    @items = items
  end

  def perform
    return unless drop?

    avatar.drop_item if avatar.backpack_full?

    avatar.item_inventories.create(item: picked_item.item)
  end

  def drop?
    @drop ||= (picked_item&.weight || 0) > Random.rand(0..100)
  end

  def picked_item
    @picked_item ||= possible_items.sample
  end

  def possible_items
    @possible_items ||= ItemDrop.where(category: items)
  end
end
