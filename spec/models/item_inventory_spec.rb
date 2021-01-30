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
require 'rails_helper'

RSpec.describe ItemInventory, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
