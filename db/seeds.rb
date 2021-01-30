# frozen_string_literal: true

require 'csv'

items =
  CSV
  .open(Rails.root.join('db/fixtures/items.csv'), headers: true)
  .map { |item| Item.new(item.to_h) }

Item.import items, on_duplicate_key_update: %i[name icon_name asset_name type value]

drops =
  CSV
  .open(Rails.root.join('db/fixtures/item_drops.csv'), headers: true)
  .map { |item| ItemDrop.new(item.to_h) }

ItemDrop.import drops, on_duplicate_key_update: %i[category item_id weight]
